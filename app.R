library(shiny)
library(ggplot2)
library(dplyr)

source('functions.R')

# Define UI for application that draws a histogram
ui <- fluidPage(

   # Application title
   titlePanel("Rolling Die"),

   # Sidebar with a slider input for number of bins
   sidebarLayout(
      sidebarPanel(
         sliderInput("num_rolls",
                     "Number of rolls:",
                     min = 1,
                     max = 100,
                     value = 20)
      ),
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   output$distPlot <- renderPlot({
     
     results <- roll(1:6,times = input$num_rolls)
     results_df = make_results_df(results)
     
      # draw the histogram with the specified number of bins
      ggplot(data = results_df) +
        geom_histogram(aes(x = results_df), binwidth = 1)
   })
}

# Run the application
shinyApp(ui = ui, server = server)

