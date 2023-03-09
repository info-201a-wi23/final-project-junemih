library("shiny")
library("ggplot2")
library("dplyr")
library("plotly")
library("bslib")

# Define server logic
server <- function(input, output) {
  
  spotify_data <- read.csv("data_moods.csv", stringsAsFactors = FALSE)
  
  spotify_data$year <- as.numeric(format(as.Date(spotify_data$release_date), "%Y"))
  
  spotify_data$minutes <- spotify_data$length / 60000
  
  subset_data <- reactive({
    subset(spotify_data, year >= input$year_range[1] & year <= input$year_range[2])
  })
  
  popular_songs <- reactive({
    subset_data() %>%
      group_by(year) %>%
      slice_max(order_by = popularity) %>%
      distinct(popularity, .keep_all = TRUE)
  })
  
  song_data <- reactive({
    spotify_data %>%
      mutate(duration_min = round(length / 60000, 2)) %>%
      filter(popularity >= input$popularity_slider[1], popularity <= input$popularity_slider[2])
  })
  
  output$chart1 <- renderPlotly({
    chart1 <- ggplot(popular_songs(), aes(x = year, y = popularity, label = name, text = paste(artist, " - ", popularity))) +
      geom_point(size = 3, color = "#FFB967") +
      geom_text(vjust = -1.5) +
      labs(title = "Most Popular Song by Year", x = "Year", y = "Popularity")
    ggplotly(chart1, tooltip = c("popularity"))
  })
  
  output$chart2 <- renderPlotly({
    ggplotly(
      ggplot(data = spotify_data, aes_string(x = input$xvar2, y = "energy")) +
        geom_smooth(alpha = 0.5) +
        labs(x = input$xvar2, y = "Energy", title = "How Sound Traits Impact Energy")
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
        scale_color_brewer(type = "qual", palette = "Accent") +
        labs(title = "Do Duration and Mood Correlate with Popularity?", x = "Duration (minutes)", y = "Popularity", color = "Mood")
    )
    
  })
}



