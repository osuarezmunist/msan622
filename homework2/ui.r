# ui.R
# Just setting up input widgets
shinyUI(pageWithSidebar(
  headerPanel("Exploring Movie Budgets by Genre"),

  
    sidebarPanel( 
      
      radioButtons("mpaa", label = h6("Radio buttons"),
                   choices = list("All", "NC-17","PG", "PG-13","R"),selected = "All"),
      
      checkboxGroupInput("checkGroup", label = h6("Genres"), 
                              choices =list("Action"=1, "Animation"=2, "Comedy"=3,"Documentary"=4,
                                 "Drama"=5,"Mixed"=6,"None"=7,"Romance"=8,"Short"=9),
                         selected=1
      ),
      sliderInput("minbudget", label = h6("Minimum budget in millions"),
                  min = 1, max = 200, value = 1),
      
      sliderInput("maxbudget", label = h6("Maximum budget in millions"),
                  min = 1, max = 200, value = 200),
      width=2
    ),
    mainPanel(plotOutput("plot1"), width = 10)
  )
)
