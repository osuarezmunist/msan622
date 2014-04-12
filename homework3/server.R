library(shiny)
library(reshape)
library(ggplot2)
library(scales)
library(reshape2)
require(GGally)


getScatterPlot <- function(geozoom,checkGroup) {

  x77<- data.frame(state.x77,
                   State = state.name,
                   Abbrev = state.abb,
                   Region = state.region,
                   Division = state.division
  )
  
  #Scatter plot
  if (checkGroup == "Murder") x77$yvar <- x77$Murder
  else if (checkGroup == "Illiteracy") x77$yvar <- x77$Illiteracy
  else if (checkGroup == "HS Graduation") x77$yvar <- x77$HS.Grad
  else if (checkGroup == "Income") x77$yvar <- x77$Income
  else if (checkGroup == "Frost") x77$yvar <- x77$Frost
  
  
  if (geozoom=="Division") {
    p <- ggplot(x77,aes(x=Life.Exp,y=yvar,color=Division))+geom_point()
  } else if (geozoom=="Region") {
    p <- ggplot(x77,aes(x=Life.Exp,y=yvar,color=Region))+geom_point()
  } else if (geozoom=="State") {
    p <- ggplot(x77,aes(x=Life.Exp,y=yvar,color=State))+geom_point()+theme(legend.position="none")
  }
  
  if (checkGroup == "Murder") p <- p +xlab("Life Expectancy")+ylab("Murder")
  else if (checkGroup == "Illiteracy") p <- p +xlab("Life Expectancy")+ylab("Illiteracy")
  else if (checkGroup == "HS Graduation") p <- p +xlab("Life Expectancy")+ylab("HS Graduation")
  else if (checkGroup == "Income") p <- p +xlab("Life Expectancy")+ylab("Income")
  else if (checkGroup == "Frost") p <- p +xlab("Life Expectancy")+ylab("Frost")
  
  plot(p)
  
  #p <- p +scale_x_continuous(labels = dollar)+scale_y_continuous(limits=c(0,10))
  #p <- p +xlab("Budget")+ylab("Rating")
 
}

getSmallMult <- function(geozoom,checkGroup) {
  
  x77<- data.frame(state.x77,
                   State = state.name,
                   Abbrev = state.abb,
                   Region = state.region,
                   Division = state.division
  )
  
  if (checkGroup == "Murder") x77$yvar <- x77$Murder
  else if (checkGroup == "Illiteracy") x77$yvar <- x77$Illiteracy
  else if (checkGroup == "HS Graduation") x77$yvar <- x77$HS.Grad
  else if (checkGroup == "Income") x77$yvar <- x77$Income
  else if (checkGroup == "Frost") x77$yvar <- x77$Frost
  #Small Mult
  if (geozoom=="Division") {
    p <- ggplot(x77,aes(x=Life.Exp,y=yvar))+geom_point()+facet_wrap(~Division, ncol=2)
  } else if (geozoom=="Region") {
    p <- ggplot(x77,aes(x=Life.Exp,y=yvar))+geom_point()+facet_wrap(~Region, ncol=2)
  } else if (geozoom=="State") {
    return(NULL)
  }
  
  if (checkGroup == "Murder") p <- p +xlab("Life Expectancy")+ylab("Murder")
  else if (checkGroup == "Illiteracy") p <- p +xlab("Life Expectancy")+ylab("Illiteracy")
  else if (checkGroup == "HS Graduation") p <- p +xlab("Life Expectancy")+ylab("HS Graduation")
  else if (checkGroup == "Income") p <- p +xlab("Life Expectancy")+ylab("Income")
  else if (checkGroup == "Frost") p <- p +xlab("Life Expectancy")+ylab("Frost")
  
  plot(p)
  
  
}

getParCoord <- function(geozoom) {
  
  x77<- data.frame(state.x77,
                   State = state.name,
                   Abbrev = state.abb,
                   Region = state.region,
                   Division = state.division
  )
  
  #Parallel Coord
  if (geozoom=="Division") {
    pc <- ggparcoord(x77,columns = c(2,3,5:7), groupColumn =12,scale = "uniminmax", ) + geom_line()
  } else if (geozoom=="Region") {
    pc <- ggparcoord(x77,columns = c(2,3,5:7), groupColumn =11,scale = "uniminmax", ) + geom_line()
  } else if (geozoom=="State") {
    return(NULL)
      }
  plot(pc)
  
}

getHeatMap <- function(geozoom) {
  
  x77<- data.frame(state.x77,
                   State = state.name,
                   Abbrev = state.abb,
                   Region = state.region,
                   Division = state.division
  )
  
  # Reverse order geogrpahical categories to appear from top to bottom in Heatmap
  x77$State = with(x77, factor(State, levels = rev(levels(State))))
  x77$Region = with(x77, factor(Region, levels = rev(levels(Region))))
  x77$Division = with(x77, factor(Division, levels = rev(levels(Division))))
  #Convert x77 to long formatfor HeatMap
  x77.m <-melt(x77, id=c("State","Abbrev","Region","Division","Life.Exp"))
  x77.m$variable <- with(x77.m,factor(variable,levels = rev(sort(unique(variable)))))
  x77.m<- ddply(x77.m, .(variable), transform,rescale = rescale(value))
  
  
  #Parallel Coord
  if (geozoom=="Division") {
    p <- ggplot(x77.m, aes(variable,Division)) 
  } else if (geozoom=="Region") {
    p <- ggplot(x77.m, aes(variable,Region)) 
  } else if (geozoom=="State") {
    return(NULL)
  }
  p <- p + geom_tile(aes(fill = rescale),colour = "white") 
  p <- p + scale_fill_gradient(low = "white",high = "steelblue")
  plot(p)
  
}

getAnswerPlot <- function(geozoom) {
  
  x77<- data.frame(state.x77,
                   State = state.name,
                   Abbrev = state.abb,
                   Region = state.region,
                   Division = state.division
  )
  
  #Scatter plot
  #x77 <- x77[order(x77$Life.Exp),] 

  p <- ggplot(x77,aes(x=Abbrev,y=Life.Exp,group=1))+geom_line()+geom_point()
  p <- p +ylab("Life Expectancy")+xlab("State")
  plot(p)
  

}

# server.R

shinyServer(
  function(input, output) {
    
    output$splot <- renderPlot({ 
      
      print(getScatterPlot(input$geozoom,input$checkGroup))
             
    })
    output$smult <- renderPlot({ 
      
      print(getSmallMult(input$geozoom,input$checkGroup))
      
    })
    output$parcoord <- renderPlot({ 
      
      print(getParCoord(input$geozoom))
      
    })
    output$heatmap <- renderPlot({ 
      
      print(getHeatMap(input$geozoom))
      
    })    
    output$aplot <- renderPlot({ 
      
      print(getAnswerPlot(input$geozoom))
      
    })
    
  } 
)



