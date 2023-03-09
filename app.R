library("shiny")
library("ggplot2")
library("plotly")
library("dplyr")

source("/Users/junem/OneDrive/Desktop/info201/final-project-junemih/ui.R")
source("/Users/junem/OneDrive/Desktop/info201/final-project-junemih/server.R")


#"/Users/junem/Downloads/p03data.csv"
#"/Users/junem/OneDrive/Desktop/info201/final-project-junemih/data_moods.csv"
#"/Users/junem/OneDrive/Desktop/info201/final-project-junemih/"
#"/Users/junem/OneDrive/Desktop/info201/final-project-junemih/final/"

#Run the application
shinyApp(ui = ui, server = server)
