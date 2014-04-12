# ui.R
# Just setting up input widgets
shinyUI(pageWithSidebar(
  headerPanel("If you could choose one State to live in to Maximize your Life Expectancy in 1977, what woud it be?"),

  
    sidebarPanel( 
      
      radioButtons("geozoom", label = h6("Geographical Zoom Level"),
                   choices = list("Division", "Region","State"),selected = "Division"),
      
      radioButtons("checkGroup", label = h6("Variable to Examine"), 
                              choices =list("Murder", "Illiteracy", "HS Graduation",
                                            "Frost", "Income"),
                         selected="Murder"
      ),
      width=2
    ),
    mainPanel(
      tabsetPanel(
        
        tabPanel("Start",       
          h5("State Level Legend not shown"),
          plotOutput("splot"), 
          width = 10
        ),
        tabPanel("Small Multiples", 
          h5("State Level Plots not shown"),
          plotOutput("smult"), 
          width = 10
        ),
        tabPanel("Parallel Coordinates",
          h5("State Level Plot not shown"),
          plotOutput("parcoord"),  
          width = 10
        ),
        tabPanel("Heat Map",
          h5("State Level Heat Map not shown"),
          plotOutput("heatmap"), 
          width = 10
        ),
        tabPanel("Answer", h4("Did you choose wisely?"),
                 plotOutput("aplot"), 
                 width = 10        
        )
      )

  )
))
