# PyData Shiny Demo
# C. Ashton Drew
# KDV Decision Analysis LLC

library(ggplot2)
library(plotly)
library(leaflet)
qDat <- quakes

ui <- fluidPage(
  titlePanel("pyData Shiny Demo"),
  sidebarLayout(
    sidebarPanel(
      h3("Fiji Earthquake Data"),
      sliderInput("sld01_Mag",
                  label="Show data for earthquakes of magnitude:", 
                  min=min(qDat$mag), max=max(qDat$mag),
                  value=c(min(qDat$mag),max(qDat$mag)), step=0.1)
    ),
    mainPanel(
      plotlyOutput("hist01"),
      dataTableOutput("table01")
    )
  )
)

server <- shinyServer(function(input, output) {
  output$hist01 <- renderPlotly({
    qSub <- qDat[qDat$mag>=input$sld01_Mag[1] & qDat$mag<=input$sld01_Mag[2],]
    ggplot(data=qSub, aes(x=stations))+
      geom_histogram(binwidth=5)+
      xlab("Number of Reporting Stations")+ 
      xlim(min(qDat$stations), max(qDat$stations))+
      ylab("Count")+
      ggtitle("Earthquakes near Fiji")
  })
  output$table01 <- renderDataTable({
    qSub2 <- qDat[qDat$mag>=input$sld01_Mag[1] & qDat$mag<=input$sld01_Mag[2],]
  })
})

shinyApp(ui = ui, server = server)