#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

# Define UI for application that draws a histogram

fndata <- read.csv("data/fortnite.csv",stringsAsFactors=FALSE)
ui <- fluidPage(
    
    # Application title
    titlePanel("Fortnite visualization"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        
        sidebarPanel(
            selectInput("player_name",
                        label="Choose a player name",
                        choices=unique(fndata$player_name),
                        selected="Ninja"),
            selectInput("platform",
                        label="Choose a gaming platform psn/pc right now",
                        choices=c('pc','psn'))

            ),
        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("kills")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

        
    
    
    output$kills <- renderPlot({
        
        x <- fndata %>% filter(player_name == input$player_name & fndata$platform== input$platform)
        hist(x$kills,main="histogram of kills for 10 games")

})
    
}
# Run the application 
shinyApp(ui = ui, server = server)

