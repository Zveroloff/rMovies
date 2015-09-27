randoms <- runif(5, max = 1030)
samples <- floor(randoms)
ratings <- read.csv("data\\ratings.csv")

sel <- ratings$movieId %in% samples
watched <- ratings[sel,]
liked <- watched[watched$rating > 3,"userId"]
recommend <- ratings[ratings$userId %in% liked,]
sel <- recommend$movieId %in% samples
recommend <- recommend[!sel,]
recommend <- recommend[recommend$rating > 3,]
require(data.table)
recommend <- data.table(recommend)
rec.aggr <- recommend[,sum(rating), by = movieId]
rec.aggr <- rec.aggr[order(-V1)]
sel <- head(rec.aggr, 5)[,movieId]
movies <- read.csv("data\\movies.csv")
as.character(movies[sel,"title"])

ratings <- read.csv("data/ratings.csv")
movies <- read.csv("data/movies.csv")
movies$title <- as.character(movies$title)
namlen <- nchar(movies$title)
movies$year <- substr(movies$title, namlen - 5, namlen - 1)
