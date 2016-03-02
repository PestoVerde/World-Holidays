#Attaching libraries
libs <- c("shiny", "plotly", 
          "ggplot2", "ggmap", 
          "maps", "mapdata", 
          "countrycode", "dplyr")
sapply(libs, library, character.only = T, logical.return = T, 
       quietly = T, warn.conflicts = F)

#Loading data
load('noh.RData')

shinyServer(function(input, output){
    
#Preparing map data
    w <- map_data("world")
    w$code <- countrycode(w$region, "country.name", "iso3c")
    w <- left_join(w, noh, by = "code")

#Choosing amount of Indian holidays        
    dataset <- reactive({
        ifelse(input$radio == 1, noh$to.show <- noh[,2], 
               noh$to.show <- noh[,4])
        noh
    })
    
#Creating plotly graph     
    output$trendPlot <- renderPlotly({
        l <- list(color = toRGB("grey"), width = 0.5)
        
        g <- list(
            showframe = FALSE,
            showcoastlines = FALSE,
            projection = list(type = "natural earth"),
            bgcolor = "rgb(39,43,48)",
            framecolor = "rgb(39,43,48)"
        )
        
        cb = list(title = 'Number of<br> holidays',
                  titlefont = list(titlefont = "white"),
                  #tickvals = c("a", "b", "c", "d"),
                  thickness = 10,
                  len = 0.5)
        
        plot_ly(dataset(), 
                z = to.show, 
                text = Country, 
                locations = code, 
                type = 'choropleth', 
                color =  to.show, 
                colors = 'YlOrRd', 
                marker = list(line = l), 
                colorbar = cb) %>% layout(geo = g, 
                                          paper_bgcolor ="rgb(39,43,48)")
    })
    
#Creating ggplot2 graph     
    output$distPlot <- renderPlot({
        
        no.axes <- theme(
            axis.text = element_blank(),
            axis.line = element_blank(),
            axis.ticks = element_blank(),
            panel.border = element_blank(),
            panel.grid = element_blank(),
            axis.title = element_blank(),
            plot.background = element_rect(fill = rgb(39/256,43/256,48/256)), 
            panel.background = element_rect(fill = rgb(39/256,43/256,48/256)), 
            legend.background = element_rect(fill = rgb(39/256,43/256,48/256)),
            text = element_text(colour = "white")
        )
        
        ggplot() + 
            geom_polygon(data = w, 
                         aes(x=long, y = lat, fill = notes, group = group)) + 
            coord_fixed(1) +
            no.axes
     }, bg="transparent")

#Creating data table         
    output$table1 <- renderDataTable( 
        
        noh[,c(1,2,5)],
        options = list(
            lengthMenu = list(c(5, 15, -1), c('5', '15', 'All')),
            pageLength = 15)
        )    
    
})#shinyServer

