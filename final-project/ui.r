# ui.R
# Just setting up input widgets
shinyUI(pageWithSidebar(
  headerPanel("Analysis of Student PreSurvey"),

  
    sidebarPanel( 
      
      checkboxGroupInput("ordinals", label = h6("Ordinal Variables"),
                    choices = numnames,selected = numnames),
      
      radioButtons("categoricals", label = h6("Disaggregate/Group by Categorical Variable"), 
                              choices =c("None",catnames)
      ),
      width=2
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Questionnaire",       
                 h5("Learner Profile Questions (response values hidden on public copy of data)"),
                 tableOutput("ddtab"), 
                 width = 10
        ),
        tabPanel("Correlations",
                 h5("Heatmap of Bivariate Correlations"),
                 plotOutput("heatmap"), 
                 width = 10
        ),

        tabPanel("Variable Frequencies", 
          h5("Bar charts of Selected Variables"),
          plotOutput("smult",height = 1000), 
          height = 1000, width = 10
        ),
        tabPanel("Factor Analysis",
          h5("State Level Plot not shown"),
          plotOutput("factorplot"),  
          width = 10
        ),
        tabPanel("Parallel Coordinates", h4("Parallel Coordinates Plot of Selected Variables"),
                 plotOutput("parcoord"), 
                 width = 10        
        )

      )

  )
))
