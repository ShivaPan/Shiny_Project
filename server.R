
library(shiny)
library(dplyr)
library(ggplot2)
library(leaflet)
source ("global.R")

shinyServer(function(input, output) {
   
  output$table1 = renderPlot({
    table1plot
  })
  
  output$table2 = renderPlot({
    table2plot
  })
  
  output$table3 = renderPlot({
    table3plot
  })
  
  #Dropdown menu which outputs bar plots based on user selected "state"
  output$plots = renderPlot({
    print(input$State)
    z= vegnum %>% filter(., state==input$State) %>% group_by(., city) %>% 
      summarise(., number = n()) %>% arrange(desc(number))
    
    ggplot(z[1:15,], aes(x= reorder(city, -number), y = number)) + 
      geom_bar(stat = "identity", fill="#19f17b", colour="black") + 
      theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 15),
            axis.text.y = element_text(size = 15),
            axis.title.x = element_text(size=12), axis.title.y = element_text(size = 12)) + 
      xlab("City") + ylab("Number of restaurants")
    
  })

})
