library(shiny)
library(reshape)
library(ggplot2)
library(scales)
library(reshape2)
require(GGally)
require(psych)
require(GPArotation)


# Get needed files
sur <- read.csv("PreSurveyR.csv")
dd <- read.csv("DataDictionaryR.csv")


#Hardcoded for now, but will read from dd later.
#Select ordinal Qs for analysis
surnum <- sur[,c(-29:-53)]
surnum <- surnum[,c(-1:-4)]
numnames <- colnames(surnum)
attach(sur)
surcat <- data.frame(Q02,Q13,Q14,Q15,Q17)
catnames <-colnames(surcat)

getHeatMap <- function(ordinals) {
# Grab user-selected variables  
  numselect <- NULL
  for (i in 1:ncol(surnum)) {
    if (colnames(surnum)[i] %in% ordinals) numselect <- c(numselect,colnames(surnum)[i])
  }
# Calculate correlations
  correlations <- cor(surnum[,numselect] , use = "everything")
  for (i in 1:nrow(correlations) ) {
    correlations[i,i] <- NA
  }

#Melt and plot
  cor.m <- melt(correlations)
  
  p <- ggplot(cor.m, aes(X1, X2)) 
  p <- p + geom_tile(aes(fill = value),colour = "white") + scale_fill_gradient(low = "white",high = "steelblue")
  #p <- p + scale_colour_brewer(type = "div", palette = 1)
  p <- p + scale_fill_gradient2(midpoint=0, low="#B2182B", high="#2166AC")
  p <- p + ggtitle("Bivariate Correlations between Selected Variables")
  p <- p + ylab("Variable ID") + xlab("Variable ID")
  p <- p +theme(axis.text.x = element_text(angle = -90))
  plot(p)
  
}

getSmallMult  <- function(ordinals,categoricals) {
  # Grab user-selected variables  
  numselect <- NULL
  for (i in 1:ncol(surnum)) {
    if (colnames(surnum)[i] %in% ordinals) numselect <- c(numselect,colnames(surnum)[i])
  }

  if (categoricals != "None") {
    for (i in 1:ncol(surcat)) {
      if (colnames(surcat)[i] %in% categoricals) catselect <- colnames(surcat)[i]
    }
    bsur <- surnum[,numselect]
    bsur$GroupingBy <-factor(surcat[,catselect])
    sur.m <- melt(bsur, id.vars=c("GroupingBy"))
    
    # Add labels, title
    p <- ggplot(sur.m, aes(factor(value),fill=GroupingBy)) + geom_bar() +  facet_wrap(~ variable)
  } else {

    bsur <- surnum[,numselect]
    sur.m <- melt(bsur)
    
    # Add labels, title
    p <- ggplot(sur.m, aes(factor(value))) + geom_bar() +  facet_wrap(~ variable)

  }
p <- p + ggtitle("Response Frequencies for Selected Variables")
p <- p + ylab("Raw Count") + xlab("Response (1:Strongly Agree-5:Strongly Disagree)")
plot(p)  
    
}

getFactorAnalysis  <- function(ordinals) {
  # Grab user-selected variables  
  numselect <- NULL
  for (i in 1:ncol(surnum)) {
    if (colnames(surnum)[i] %in% ordinals) numselect <- c(numselect,colnames(surnum)[i])
  }

  # Factor anlysis
  varexp <- matrix(0,10,10,
                   dimnames=list(1:10,c("NF1","NF2","NF3","NF4","NF5","NF6","NF7","NF8","NF9","NF10")))
  for (i in 1:10)  {
    fit <- principal(surnum[,numselect], nfactors=i,rotate="varimax")
    capture.output( print(fit$loadings), file=paste("fitloadings",i,".txt"))
    fr <- read.delim(paste("fitloadings",i,".txt"), sep="\t", fill=TRUE, header=FALSE,
                     stringsAsFactors=FALSE)
    for (j in 1:i) {
      varexp[j,i] <- as.numeric(substr(fr$V1[5+ncol(surnum[,numselect])],10+6*j,15+6*j))
    } 
  }
  ve <-data.frame(varexp)
  ve$comp <- 1:10
  ve.m <- melt(ve, na.rm=TRUE,id=c("comp"))
  
  p <- ggplot(ve.m, aes(comp, value, group=variable,color=variable)) 
  p <- p + geom_line()+ geom_point()
  p <- ggplot(ve.m, aes(x=variable,y=value,fill=factor(comp))) + geom_bar(stat="identity")
  p <- p + ggtitle("Proportion Variance Explained by Number of Factors in PCA")
  p <- p + ylab("Proportion Variance Explained") 
  p <- p + xlab("Number of Factors in CFA stacked by order of extraction")
  p <- p +theme(legend.position="none")
  p <- p + scale_fill_brewer(type="qual", palette=3)
  plot(p)

  plot(p)
  
}

getParCoordPlot  <- function(ordinals,categoricals) {
  # Grab user-selected variables  
  numselect <- NULL
  for (i in 1:ncol(surnum)) {
    if (colnames(surnum)[i] %in% ordinals) numselect <- c(numselect,colnames(surnum)[i])
  }
  pcdf <- surnum[,numselect]
  if (categoricals != "None") {
    for (i in 1:ncol(surcat)) {
      if (colnames(surcat)[i] %in% categoricals) catselect <- colnames(surcat)[i]
    }
    pcdf$Grouping <- factor(surcat[,catselect])
    pc <- ggparcoord(pcdf,columns = c(1:ncol(pcdf)-1), 
                     groupColumn =ncol(pcdf), order = "skewness",
                     scale = "globalminmax",alphaLines=.01 ) #+ geom_line()
    pc <- pc + guides(colour = guide_legend(override.aes = list(alpha = 1)))
  } else {
  #Parallel Coord
 
    pc <- ggparcoord(pcdf,columns = c(1:ncol(pcdf)), order = "skewness",
                     scale = "globalminmax",alphaLines=.01 ) #+ geom_line()
  }
  pc <- pc + theme(axis.text.x = element_text(angle = 270, hjust = 0))
  plot(pc)
}


# server.R

shinyServer(
  function(input, output) {
    
    output$ddtab <- renderTable({ 
      
      dd
             
    })
    output$smult <- renderPlot({ 
      
      print(getSmallMult(input$ordinals,input$categoricals))
      
    })
    output$factorplot <- renderPlot({ 
      
      print(getFactorAnalysis(input$ordinals))
      
    })
    output$heatmap <- renderPlot({ 
      
      print(getHeatMap(input$ordinals))
      
    })    
    output$parcoord <- renderPlot({ 
      
      print(getParCoordPlot(input$ordinals,input$categoricals))
      
    })
    output$textout <- renderText({ 
      
      input$categoricals
      
    })
  } 
)



