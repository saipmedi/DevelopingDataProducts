library(shiny)
library(dplyr)
library(ggplot2)
setwd("C:/Users/Student/Desktop/RWorkingDir/shiny/FootballPrediction")
theData <- read.csv("raw_data.csv", header = TRUE, sep = ",")

shinyUI(
    
    # Costumize layout using a fluid Bootstrap
    fluidPage(    
        
        # Application Title
        titlePanel("English Football Stats Custom Viewer"),
        
        # Generate a row with a sidebar
        sidebarLayout(      
            
            # Define the sidebar with one input
            sidebarPanel(
                selectInput("tier", "Division:", choices=c(1,2,3,4)),
                selectInput("themetric", "Metric:", choices=c('Total_Goals', 'Goals_Per_Game', 'Home_Team_Goals', 'Home_Team_GPG', 'Away_Team_Goals', 'Away_Team_GPG', "Home_Goal_Difference")),
                sliderInput("season", "Season Range", 1888, 2013, value = c(1970, 2013)),
                hr(),
                helpText("This app allows the user to explore the dataset compiled by James Curley that 
                                         has the results and goals for every league game of UK professional football from the 1880s:
                                         https://github.com/jalapic/engsoccerdata.",
                         hr(),
                         "Select the metric you wish to see, the seasons required and 
                                         the division you are interested in")
            ),
            
            # Reserve space for the barplot
            mainPanel(
                plotOutput("footballPlot")  
            )
            
        )
    )
)