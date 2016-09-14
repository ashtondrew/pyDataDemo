# pyData Workshop
# Ashton Drew
# KDV Decision Analysis LLC
# ashton@kdv-decisions.com

# All examples use the builtin dataset 'quakes' of Fiji earthquakes
head(quakes)
summary(quakes)

#Basic Interactive Table
library(DT)
datatable(quakes)

#Prettier Table
datatable(data=quakes, 
          rownames=FALSE, 
          colnames=c("Latitude", "Longitude", "Depth (km)", "Magnitude", "Number of Reporting Stations"),
          filter="top",
          caption="Table 1. Earthquakes near Fiji"
)

# Basic Interactive Plot
library(plotly)
plot_ly(quakes, x=depth, y=mag, mode="markers")

# Prettier plot leveraging ggplot
library(ggplot2)
qGraph <- ggplot(data=quakes, aes(x=depth, y=mag, color=stations))+
  geom_point()+
  scale_color_gradient(low="yellow", high="red", name="Number of Stations")+
  xlab("Depth (m)")+
  ylab("Magnitude")+
  ggtitle("Earthquakes near Fiji")
ggplotly(qGraph, tooltip=c("x", "y", "colour"))

# Basic Interactive Map
library(leaflet)
qMap <- leaflet(data = quakes) %>% 
  addTiles() %>%
  addMarkers(~long, ~lat, popup = ~as.character(mag))
qMap

# Prettier Map
# Create a palette that maps factor levels to colors
pal <- colorNumeric("YlOrRd", domain=c(min(quakes$mag), max(quakes$mag)))

qMap <- leaflet(data = quakes) %>% 
  addTiles() %>%
  addCircleMarkers(
    radius = 2,
    color = ~pal(mag),
    stroke = FALSE, fillOpacity = 1, popup=~as.character(mag)) %>%
  addLegend("bottomright", pal = pal, values = ~mag,
            title = "Earthquake Magnitude",
            opacity = 1)
qMap