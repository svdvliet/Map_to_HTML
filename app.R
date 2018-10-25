library(Racmacs)
library(shiny)
library(htmlwidgets)

ui <- shinyUI(
  fluidPage(
    title = "Map to HTML converter",
    column(5,offset = 4, titlePanel("Convert map to HTML viewer")),
    tags$hr(),


    fileInput("file1", "Choose map to upload", accept = c(".save",".ace")),
    tags$hr(),
    downloadButton("downloadData", "Download")
  )
)

server <- function(input, output) {

  values <- reactiveValues()

  observeEvent(input$file1,{
    values$map <- Racmacs::read_acmap(input$file1$datapath)
    options(viewer = NULL)
      })

  output$downloadData <- downloadHandler(
    filename = function() {
      #Change output name
      sub("[.].*", ".html", input$file1$name)
         },
    content = function(file) {
     mapdata <- view_map(values$map)
      saveWidget(mapdata, file = file, selfcontained = T)
   })
}

shinyApp(ui, server)
