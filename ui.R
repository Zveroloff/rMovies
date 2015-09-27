
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(data.table)


shinyUI(fluidPage(

  # Application title
  titlePanel("What to watch next?"),

  # Sidebar with checkboxes to mark movies you liked
  sidebarLayout(
    sidebarPanel(
            uiOutput("cbList"),
            br(),
            submitButton("Get new movies!")
    ),

    # Show the list of recommended movies.
    mainPanel(
            h3("Help"),
            div("To get an advice for future watching,
                just select titles you liked on the left
                panel and push the button. 
                The system will calculate recommendations for you.
                If there are no titles you know, just refresh the page."),
            
            h3("Recommended movies"),
            verbatimTextOutput("rec")
    )
  )
))
