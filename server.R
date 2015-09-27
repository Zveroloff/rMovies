
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(data.table)


ratings <- read.csv("data/ratings.csv")
movies <- read.csv("data/movies.csv")
movies$title <- as.character(movies$title)
namlen <- nchar(movies$title)
movies$year <- substr(movies$title, namlen - 4, namlen - 1)
last20yrs <- c("1995",
               "1996",
               "1997",
               "1998",
               "1999",
               "2000",
               "2001",
               "2002",
               "2003",
               "2004",
               "2005",
               "2006",
               "2007",
               "2008",
               "2009",
               "2010",
               "2011",
               "2012",
               "2013",
               "2014",
               "2015")
mov.modern <- movies[movies$year %in% last20yrs,]

shinyServer(function(input, output) {

    mov.select <- movies[movies$movieId %in% sample(mov.modern$movieId, 5, replace = FALSE), ]
    output$cbList <- renderUI({checkboxGroupInput("marked",
                                                  label = h3("Select movies that you liked:"),
                                                  as.list(as.character(mov.select$title)))})
    
    output$rec <- renderPrint({
            mov.liked <- mov.select[mov.select$title %in% input$marked, "movieId"]
            sel <- ratings$movieId %in% mov.liked
            watched <- ratings[sel,]
            com.liked <- watched[watched$rating > 3,"userId"]
            recommend <- ratings[ratings$userId %in% com.liked,]
            ## removing already watched movies
            sel <- recommend$movieId %in% mov.liked
            recommend <- recommend[!sel,]
            recommend <- recommend[recommend$rating > 3,]
            recommend <- data.table(recommend)
            rec.aggr <- recommend[,sum(rating), by = movieId]
            rec.aggr <- rec.aggr[order(-V1)]
            sel <- head(rec.aggr, 5)[,movieId]
            sel <- sel[!is.na(sel)]
            t <- as.character(movies[sel,"title"])
            t
            })

})
