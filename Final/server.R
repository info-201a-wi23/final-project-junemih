library("shiny")
library("ggplot2")
library("dplyr")
library("plotly")

# Define server logic
server <- function(input, output) {
  
  spotify_data <- read.csv("C:/UW/INFO201/FINAL/final-project-junemih/data_moods.csv", stringsAsFactors = FALSE)
  
  spotify_data$minutes <- spotify_data$length / 60000
  
  song_data <- reactive({
    spotify_data %>%
      mutate(duration_min = round(length / 60000, 2)) %>%
      filter(popularity >= input$popularity_slider[1], popularity <= input$popularity_slider[2])
  })
  
  output$chart1 <- renderPlotly({
    ggplotly(
      ggplot(data = spotify_data, aes_string(x = input$xvar1, y = input$yvar1)) +
        geom_point(alpha = 0.5) +
        labs(x = input$xvar1, y = input$yvar1, title = "Chart 1")
    )
  })
  
  output$chart2 <- renderPlotly({
    ggplotly(
      ggplot(data = spotify_data, aes_string(x = input$xvar2, y = input$yvar2)) +
        scale_color_brewer(type = "qual", palette = "Set3") +
        geom_point(alpha = 0.5) +
        scale_color_brewer(type = "qual", palette = "Set3") +
        labs(x = input$xvar2, y = input$yvar2, title = "Chart 2")
    )
  })
  
  output$chart3 <- renderPlotly({
    
    filtered_songs <- filter(spotify_data,
                             minutes >= input$duration[1] &
                               minutes <= input$duration[2])
    
    ggplotly(
      ggplot(data = filtered_songs,
             aes(x = minutes, y = popularity, color = mood)) +
        geom_point() +
        scale_color_brewer(type = "qual", palette = "Set2") +
        labs(x = "Duration (minutes)", y = "Popularity", color = "Mood")
    )
    
  })
  
}
