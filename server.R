library(shiny)
library(dplyr)
library(ggplot2)
library(sqldf)

theData <- read.csv("raw_data.csv", header = TRUE, sep = ",")
theData$totgoal <- as.numeric(theData$totgoal)
theData$hgoal <- as.numeric(theData$hgoal)
theData$vgoal <- as.numeric(theData$vgoal)

# Define a server for the Shiny app
shinyServer(function(input, output) {
    
    # Fill in the spot we created for a plot
    output$footballPlot <- renderPlot({
        
        # Render a barplot
        theData <- filter(theData, Season >= input$season[1], Season <= input$season[2])
        theData <- filter(theData, tier == input$tier)
        theData <- sqldf("select 
                                    Season, 
                                    sum(totgoal) as 'Total_Goals', 
                                    sum(totgoal) / count(*) as 'Goals_Per_Game',
                                    sum(hgoal) as 'Home_Team_Goals',
                                    sum(hgoal) / count(*) as 'Home_Team_GPG',
                                    sum(vgoal) as 'Away_Team_Goals',
                                    sum(vgoal) / count(*) as 'Away_Team_GPG',
                                    sum(goaldif) as 'Home_Goal_Difference'
                                 from theData 
                                 group by Season")
        metricpos <- match(input$themetric, names(theData))
        theData <- theData[, c(1,metricpos)]
        names(theData) <- c("Season", "Metric")
        ggplot(aes(x=Season, y = Metric), data = theData) + geom_bar(stat = "identity", fill = "steel blue") + ylab(input$themetric)
    })
})

