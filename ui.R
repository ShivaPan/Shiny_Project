
library(shiny)
library(shinydashboard)


shinyUI(

  
  dashboardPage( dashboardHeader(title="Select a Tab"),
 
                 #These are the dashboard tabs the user sees                
                 dashboardSidebar(
                    sidebarMenu(
                     menuItem("Top 10 Cities", tabName = "Graph1", icon = icon("dashboard")),
                     menuItem("Restaurants/State", tabName = "Graph2", icon = icon("dashboard")),
                     menuItem("City with max restaurants/state", tabName = "Graph3", icon = icon("dashboard")),
                     menuItem("Select State to View Top Cities", tabName = "Select")),
                    selectInput(inputId = "State", label = "Select your State",
                                choices = unique(vegnum$state))),

                 dashboardBody(
                   tabItems(
                     tabItem(tabName = "Graph1",
                              h2("Cities with most vegetarian restaurants"),
                             plotOutput("table1")
                             ),

                     tabItem(tabName = "Graph2",
                             h2("Number of vegetarian restaurants per state"),
                             plotOutput("table2", height = "790px")
                             ),
                     tabItem(tabName = "Graph3",
                             h2("Cities with the largest number of restaurants per state"),
                             plotOutput("table3", height = "800px")
                             ),
                     tabItem(tabName = "Select",
                      fluidRow(
                        plotOutput("plots")

                        )
                     )
                     )



                     )



                 )
                 )
  

    
