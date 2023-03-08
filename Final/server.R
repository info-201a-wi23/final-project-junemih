library(shiny)
library(plotly)
library(bslib)
library(shiny)

# Read in data
data_set <- read.csv("C:/UW/INFO201/FINAL/final-project-junemih/data_moods.csv", stringsAsFactors = FALSE)

grouped_data <- data_set %>%
  mutate(Year = str_sub(release_date, start = 1, end = 4)) %>%
  group_by(Year, mood) %>%
  summarise(mean_valence = mean(valence, na.rm = TRUE))

subset_data <- grouped_data%>%  filter(mood %in% c( "Happy", "Sad", "Energetic", "Calm"))

# Define server logic required to draw a histogram
server <- function(input, output) {

  output$mood_plot <- renderPlotly({
    
    filtered_data <- subset_data %>%
      # Filter for year
      filter(Gender %in% input$year_selection) %>%
      # Filter for type of mood
      filter(Mood %in% input$mood_selection)
    
    
    # Create ggplot2 line plot
    mood_trend_plot <-ggplot(data = filtered_data) +
      geom_line(mapping =
                  aes(x = Year,
                      y = mean_valence,
                      color = mood))
    
    return(mood_trend_plot)
  })
  
}
