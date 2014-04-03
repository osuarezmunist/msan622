library(shiny)
library(scales)
data("movies", package = "ggplot2")

getPlot <- function(highlight,mpaaRB,minb,maxb) {
  genre <- rep(NA, nrow(movies))
  count <- rowSums(movies[, 18:24])
  genre[which(count > 1)] = "Mixed"
  genre[which(count < 1)] = "None"
  genre[which(count == 1 & movies$Action == 1)] = "Action"
  genre[which(count == 1 & movies$Animation == 1)] = "Animation"
  genre[which(count == 1 & movies$Comedy == 1)] = "Comedy"
  genre[which(count == 1 & movies$Drama == 1)] = "Drama"
  genre[which(count == 1 & movies$Documentary == 1)] = "Documentary"
  genre[which(count == 1 & movies$Romance == 1)] = "Romance"
  genre[which(count == 1 & movies$Short == 1)] = "Short"
  movies$genre <-genre
  movies <- subset(movies, budget>0)
  
   # filter by budget amounts
  if (minb+maxb>0) {
    moviesB <-subset(movies, budget >= minb*1000000 & budget <=maxb*1000000)
  } else {
    moviesB <-movies
  }
  
  # gray out if not selected
  palette <- brewer_pal(type = "qual", palette = "Set1")(9)
  # Need to re-code with switch; may perform more than change.
  if (!1 %in% highlight ) { 
  palette[1] <- "#EEEEEE"
  }
  if (!2 %in% highlight ) { 
    palette[2] <- "#EEEEEE"
  }
  if (!3 %in% highlight ) { 
    palette[3] <- "#EEEEEE"
  }
  if (!4 %in% highlight ) { 
    palette[4] <- "#EEEEEE"
  }
  if (!5 %in% highlight ) { 
    palette[5] <- "#EEEEEE"
  }
  if (!6 %in% highlight ) { 
    palette[6] <- "#EEEEEE"
  }
  if (!7 %in% highlight ) { 
    palette[7] <- "#EEEEEE"
  }
  if (!8 %in% highlight ) { 
    palette[8] <- "#EEEEEE"
  }
  if (!9 %in% highlight ) { 
    palette[9] <- "#EEEEEE"
  }

  # Only show selected
  if (mpaaRB != "All") {
    moviesRB <- subset(moviesB,mpaa==mpaaRB)
  }
  else {
    moviesRB <- moviesB
  }
  
  # increase alpha level as number of dots decreases
  prop  <- nrow(movies)/nrow(moviesRB)
  if (prop>5) {prop <- 5}
  
  
  p <- ggplot(moviesRB,aes(x=budget,y=rating,color=genre))+geom_point(alpha = .2*prop)
  p <- p +scale_color_manual("Genre",values = palette)
  p <- p +scale_x_continuous(labels = dollar)+scale_y_continuous(limits=c(0,10))
  p <- p +xlab("Budget")+ylab("Rating")
 
}
# server.R

shinyServer(
  function(input, output) {
    
    #getHighlight <- reactive({
     # result <- levels(movies$Species)

      #return(result[which(result %in% input$highlight)])
    #})
    
    output$plot1 <- renderPlot({ 
      
    
      print(getPlot(input$checkGroup,input$mpaa,input$minbudget,input$maxbudget))
             
    })
    
  } 
)



