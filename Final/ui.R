library("shiny")
library("plotly")
library("ggplot2")
library("plotly")

spotify_data <- read.csv("C:/UW/INFO201/FINAL/final-project-junemih/data_moods.csv", stringsAsFactors = FALSE)

spotify_data$minutes <- spotify_data$length / 60000

# Define UI for application
ui <- fluidPage(
  
  # Application title
  titlePanel("Title"),
  h4("Authors"),
  
  
  tabsetPanel(
    
    tabPanel("Introduction",
             h1("Welcome to the Spotify Dataset Explorer!"),
             p("This app allows you to explore the Spotify dataset and visualize different trends in the data.")
    ),
    tabPanel("Chart 1",
             selectInput("xvar1", "Select X Variable", choices = c("tempo", "loudness", "speechiness")),
             selectInput("yvar1", "Select Y Variable", choices = c("danceability", "energy", "valence")),
             plotlyOutput("chart1")
    ),
    tabPanel("Chart 2",
             selectInput("xvar2", "Select X Variable", choices = c("acousticness", "instrumentalness", "liveness")),
             selectInput("yvar2", "Select Y Variable", choices = c("danceability", "energy", "valence")),
             plotlyOutput("chart2")
    ),
    tabPanel("Chart 3",
             sliderInput(inputId = "duration",
                         label = "Duration (minutes):",
                         min = 0,
                         max = max(spotify_data$length / 60000),
                         value = c(0, max(spotify_data$length / 60000))),
             plotlyOutput("chart3")
    ),
    tabPanel("Bye Bye",
             h1("Thanks for using the Spotify Dataset Explorer!"),
             includeMarkdown("C:/UW/INFO201/FINAL/final-project-junemih/final_takeaway.md"),
             p("Goodbye!")
    )
  )
)