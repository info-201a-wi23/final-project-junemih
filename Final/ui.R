library(plotly)
library(bslib)
library(shiny)
library(dplyr)

# Read in data
data_set <- read.csv("C:/UW/INFO201/FINAL/final-project-junemih/data_moods.csv", stringsAsFactors = FALSE)

# Group years together
grouped_data <- data_set %>%
  mutate(Year = str_sub(release_date, start = 1, end = 4)) %>%
  group_by(Year, mood) %>%
  summarise(mean_valence = mean(valence, na.rm = TRUE))

subset_data <- grouped_data %>%  filter(mood %in% c( "Happy", "Sad", "Energetic", "Calm"))


# Manually Determine a BootSwatch Theme
my_theme <- bs_theme(
  bg = "#0b3d91", # background color
  fg = "grey", # foreground color
  primary = "#D2B48C", # primary color
)
# Update BootSwatch Theme
my_theme <- bs_theme_update(my_theme, bootswatch = "cerulean")


# Home page tab
intro_tab <- tabPanel(
  # Title of tab
  "Introduction",
  fluidPage(
    # Include a Markdown file!
    includeMarkdown("update here"),
    p("update here")
  )
)

select_widget <-
  selectInput(
    inputId = "mood_selection",
    label = "Moods",
    choices = unique(subset_data$mood),
    selectize = TRUE,
    # True allows you to select multiple choices...
    multiple = TRUE,
    selected = "Happy"
  )



slider_widget <- sliderInput(
  inputId = "year_selection",
  label = "Years",
  min = min(1950),
  max = max(2020),
  value = c(1980, 2000),
  sep = "")

main_panel_plot <- mainPanel(
  # Make plot interactive
  plotlyOutput(outputId = "mood_trend_plot")
)

chart1 <- tabPanel(
  "Chart 1",
  sidebarLayout(
    sidebarPanel(
      select_widget,
      slider_widget
    ),
    main_panel_plot
  )
)

ui <- navbarPage(
  # Select Theme
  theme = my_theme,
  # Home page title
  "Home Page",
  intro_tab,
  chart1
)
