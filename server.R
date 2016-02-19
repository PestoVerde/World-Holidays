library(shiny)
library(plotly)
load('noh.RData')

shinyServer(function(input, output){
    l <- list(color = toRGB("grey"), width = 0.5)
    
    g <- list(
        showframe = FALSE,
        showcoastlines = FALSE,
        projection = list(type = 'Mercator')
    )
    
    plot_ly(noh, z = Freq, text = Var1, locations = code, type = 'choropleth', 
            color = Freq, colors = 'Greens', marker = list(line = l), 
            colorbar = list(title = 'Number of holidays')) %>% layout(geo = g)
})#shinyServer

