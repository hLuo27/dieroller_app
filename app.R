library(shiny)
library(ggplot2)
library(dplyr)

source('functions.R')

# Define UI for application that draws a histogram
ui <- fluidPage(

   # Application title
   titlePanel("Rolling a 6-Sided Die"),

   # Sidebar with a slider input for number of bins
   sidebarLayout(
      sidebarPanel(
         numericInput("prob1",
                      "Probability of Side 1",
                      min = 0,
                      max = 1,
                      value = 1/6),
         numericInput("prob2",
                      "Probability of Side 2",
                      min = 0,
                      max = 1,
                      value = 1/6),
         numericInput("prob3",
                      "Probability of Side 3",
                      min = 0,
                      max = 1,
                      value = 1/6),
         numericInput("prob4",
                      "Probability of Side 4",
                      min = 0,
                      max = 1,
                      value = 1/6),
         numericInput("prob5",
                      "Probability of Side 5",
                      min = 0,
                      max = 1,
                      value = 1/6),
         numericInput("prob6",
                      "Probability of Side 6",
                      min = 0,
                      max = 1,
                      value = 1/6),
         textInput("side1",
                    "Value of Side 1",
                    value = "1"),
         textInput("side2",
                   "Value of Side 2",
                   value = "2"),
         textInput("side3",
                   "Value of Side 3",
                   value = "3"),
         textInput("side4",
                   "Value of Side 4",
                   value = "4"),
         textInput("side5",
                   "Value of Side 5",
                   value = "5"),
         textInput("side6",
                   "Value of Side 6",
                   value = "6")
      ),
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot"),
         
         sliderInput("num_rolls",
                     "Number of rolls:",
                     min = 1,
                     max = 100,
                     value = 20),
         numericInput("seed",
                      "Set the random seed:",
                      min = 1,
                      value = 123)
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   output$distPlot <- renderPlot({
     
     if(round(input$prob1 + input$prob2 + input$prob3 + input$prob4 + input$prob5 + input$prob6,digits = 2) != 1){
       stop("Error: Probabilities must sum up to 1")
     }
     
     set.seed(input$seed)
     results <- roll(c(input$side1, input$side2, input$side3, input$side4, input$side5, input$side6),times = input$num_rolls, 
                     p = c(input$prob1, input$prob2, input$prob3, input$prob4, input$prob5, input$prob6))
     results_df = make_results_df(results)
     
      # draw the histogram with the specified number of bins
      ggplot(data = results_df) +
        geom_col(aes(x = Side, y = Frequency, fill = Side)) +
        theme_classic() +
        ggtitle("Distribution of Die Rolls")
   })
}

# Run the application
shinyApp(ui = ui, server = server)

