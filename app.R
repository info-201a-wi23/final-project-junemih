library("shiny")
library("ggplot2")
library("plotly")
library("dplyr")

source("/Users/junem/OneDrive/Desktop/info201/ui.R")
source("/Users/junem/OneDrive/Desktop/info201/server.R")



#"/Users/junem/Downloads/p03data.csv"

#Run the application
shinyApp(ui = ui, server = server)

