#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
      # Link a google fonts
      url <- a("Google Fonts", href="https://fonts.google.com")
      output$tab <- renderUI({
        tagList("Catálogo de fuentes: ", url)
      })
  })
  
  