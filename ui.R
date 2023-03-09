library("shiny")
library("bslib")
library("plotly")
library("ggplot2")
library("plotly")

spotify_data <- read.csv("C:/UW/INFO201/FINAL/final-project-junemih/data_moods.csv", stringsAsFactors = FALSE)

spotify_data$minutes <- spotify_data$length / 60000

my_theme <- bs_theme(version = 5, bootswatch = "vapor")

# Define UI for application
ui <- fluidPage(
  
  theme = my_theme,
  
  # Application title
  titlePanel("Analyzing Music Trends"),
  h5("By Abigail Setiawan, June Mi Hong, and Paul Lam"),
  
  
  tabsetPanel(
    
    tabPanel("Introduction", 
             img(src='https://images.wondershare.com/recoverit/article/2020/08/unhide-songs-on-spotify-1.jpg', align = "center"),
             h3("Background"),
             p("Throughout history, music has been an integral part of human culture and society. Whether it's through traditional folk songs, classical compositions, or modern pop hits, music has the ability to evoke powerful emotions and affect our behavior in a variety of ways."),
             p("One of the key factors that can influence our response to music is tempo. It is commonly known that fast-paced music with a strong beat can stimulate our bodies and energize us, while slower, more melodic music can have a calming effect and help us relax. The rhythm of a song can also play a role in our behavior, with syncopated rhythms often associated with excitement and anticipation, and steady rhythms associated with stability and grounding."),
             p("Melody is another characteristic of music that can affect our behavior. Major keys and uplifting melodies can create feelings of happiness and joy, while minor keys and melancholy melodies can evoke sadness or introspection. The use of different instruments, such as strings or percussion, can also contribute to the emotional impact of a piece of music."),
             p("Lyrics are yet another important factor that can influence our behavior in response to music. The words of a song can shape our perceptions and attitudes towards certain ideas or beliefs, and can even inspire us to take action or change our behavior. For example, songs with messages of hope and unity can encourage listeners to come together and work towards a common goal, while songs with negative or violent lyrics may have the opposite effect."),
             p("Understanding how music affects behavior can be an important tool for individuals, businesses, and even entire societies. For instance, businesses can use music strategically to create a certain mood or atmosphere in their stores, while individuals can use music to enhance their workouts, relaxation routines, or social experiences. Societies can use music to bring people together and promote cultural exchange, or to express political or social messages."),
             p("In conclusion, music is a powerful tool that can influence our thoughts, emotions, and behavior in a multitude of ways. By understanding the characteristics of music and how they impact us, we can use this knowledge to enhance our experiences and promote positive outcomes in our personal and professional lives."),
             p("Click ", a(href = "https://www.kaggle.com/datasets/mrmorj/dataset-of-songs-in-spotify ", "here"), " to learn more."),
             br(),
             h3("Dataset Analysis"),
             h5("What, if any, ethical questions or questions of power do you need to consider when working with this data?"),
             p("There are not any apparent questions of power or ethical questions to think about with our data."),
             br(),
             h5("What are possible limitations or problems with this data? "),
             p("In the case of the dataset that we chose, some characteristics in the form of numbers did not include a unit, which could be ambiguous to implicate since some characteristics have multiple units that could be applied, for example is the song length column. Another example is the key column which has numbers from 1-11 as indication of the key the song is played in, which is unclear what the numbers exactly represent in the music. For this reason, this data set 
                 could be hard to work with for people with no music knowledge as it does not include a code book or other forms of resources to provide detail on the columns. It is also unstated how and for what purpose the data was generated, so the legitimacy of the dataset is a subject to obscurity. Some of the dates inside the year category also do not have a specific date of release and only mentions the year it was released, which is inconsistent. Some columns in the dataset 
                 are also filled with “0” which could mean that those specific characters in the data are “0”, but it could also mean that some data are missing. Finally, the “mood” column in the data has a relatively narrow selection of moods, considering human’s complex emotions."),
             br(),
             p("In this project, we will be answering three questions:"),
             p("1. How does a song's characteristics correlate to people’s reaction when listening to the song? "),
             p("2. How do the acousticness, instrumentalness, and liveness affect the song energy?"),
             p("3. Is the popularity of a song determined by its duration as well as its mood?")
    ),
    tabPanel("Top Songs",
             sliderInput("year_range", "Year Range", 
                         min = 1963, max = 2020, 
                         value = c(2015, 2020), step = 1),
             plotlyOutput("chart1"),
             br(),
             p("In this visualization, we can first use the slider to change the range of years we want to see on the graph in relation to the most popular song in the related year. When we hover over the datapoint, we can see the title of the song and its popularity value, which is based on the number of streams."),
             br(),
             p("As can be seen on the chart, the popular songs in the recent years have more popularity value than the popular songs in the previous years. The rise of music streaming platforms like Spotify, Apple Music, and YouTube has dramatically changed the way people consume music in recent years. Streaming services have made it easier than ever for people to access a vast library of music and to listen to their favorite songs on demand. This has led to a larger and more diverse audience for music, which in turn has increased the number of streams for popular songs. Advances in technology have also made it easier for streaming services to accurately track and report the number of streams for each song, leading to more transparency in the music industry and a better understanding of which songs are truly popular."),
             p("Additionally, streaming services have changed the way people consume music. Instead of buying albums or singles, people can now listen to individual songs as much as they want without having to purchase them. This has led to more frequent and sustained listens of popular songs, which in turn has increased their number of streams. The availability and accessibility of streaming services has made it possible for more people to discover and listen to new music, leading to a larger and more diverse audience for popular songs. As streaming continues to grow in popularity, it is likely that the most popular songs will continue to have more streams than in older years, reflecting the changing habits of music consumers and the impact of technology on the music industry."),
    ),
    tabPanel("Sound Traits",
             selectInput("xvar2", "Select Sound Trait", choices = c("acousticness", "instrumentalness", "liveness")),
             plotlyOutput("chart2"),
             br(),
             p("In this visualization we compare the relationship between energy and acousticness, instrumentalness, and liveness. When we hover over the line, it displays the value of the characteristics as well as the energy."),
             p("It can be concluded from the graph that acousticness and instrumentalness have a negative linear relationship with energy. However, it is a very different case with liveness. Liveness has a positive relationship with energy, meaning that when liveness is high, energy is also high.Acousticness and instrumentalness are two audio features that are often associated with a more subdued and relaxed sound. Acousticness measures the degree to which a track features acoustic instruments, while instrumentalness measures the degree to which a track contains only instrumental music, without vocals. These features are typically associated with a more introspective, contemplative mood, which is why they are negatively correlated with energy."),
             p("On the other hand, liveness is a measure of the presence of an audience during a live performance. When a track has a high liveness score, it typically means that it was recorded in front of a live audience, which can contribute to a sense of excitement and intensity. This is why liveness is positively correlated with energy."),
    ),
    tabPanel("Song Duration and Mood",
             sliderInput(inputId = "duration",
                         label = "Duration (minutes):",
                         min = 0,
                         max = max(spotify_data$length / 60000),
                         value = c(0, max(spotify_data$length / 60000))),
             plotlyOutput("chart3"),
             p("In this visualization, we can choose the range of song duration we’d like to see on the graph in comparison to song popularity. The different colors represent the different moods : calm, energetic, happy, and sad. When hovering on the points on the graph, we can see the length, popularity, and mood of the datapoint."),
             p("According to the graph, there doesn’t seem to be a linear relationship between duration and popularity, which means that the popularity of a song is not affected by the song duration. This could be due to the main factors that determine a song's popularity are its overall appeal and quality to listeners. A song can become popular irrespective of its duration if it has an attractive melody, captivating lyrics, and a memorable chorus or hook that resonates with listeners. Furthermore, different genres of music have different song lengths, and music streaming platforms allow listeners to skip or repeat songs as they like, reducing the significance of song duration. In conclusion, a song's duration is subjective, and its popularity depends more on its ability to emotionally connect with listeners and make a lasting impression than on its length."),
             p("However, we could see on the graph that there are more pink(sad) and purple(happy) than orange(energetic) and green(calm) dots that have popularity levels of more than 75, and that there’s more green(calm) dots in the lower part of the popularity axis. Happy and sad songs tend to be more popular than energetic and calm songs because they evoke strong emotions in listeners that are easily relatable and memorable. Happy songs can create feelings of joy, nostalgia, and optimism, while sad songs can elicit emotions like melancholy, heartbreak, and introspection. These emotions are universal and often resonate with listeners, creating a strong connection between the listener and the music. In contrast, energetic and calm songs may not always have such a profound emotional impact on listeners. Energetic songs may be enjoyable to dance or exercise to, but they may not necessarily create a lasting emotional connection with listeners. Similarly, calm songs can be relaxing and soothing, but they may not evoke as much emotion as happy or sad songs. Additionally, happy and sad songs are often more accessible to a wider audience than energetic and calm songs. They are played more frequently on radio stations and music streaming platforms, which increases their exposure and popularity."),
    ),
    tabPanel("Conclusion",
             includeMarkdown("C:/UW/INFO201/FINAL/final-project-junemih/final_takeaway.md"),
             p("Goodbye!")
    )
  )
)
