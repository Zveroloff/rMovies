Shiny movie suggest
========================================================
author: Stepan Bogoslovskiy
date: 25-09-2015

Basics
========================================================
The main purpose of this application is to suggest user
an unseen movie to watch.

The App workflow goes as follows:
- User recieves a draw of five random movies
- The draw includes only movies released in past 20 years
- User selects only movies that he seen.
- The App recommends him five unseen titles.

The data used and principles
========================================================
The MovieLens dataset is used as the base for the
recommender system. The dataset consists of 2 files:
- movies.csv
- ratings.csv
- (there are also additional files in the dataset,
but they aren't used in the App)

The core of application is a simple recommender system
based on assumption that movies have only one shared
property - the users have watched it.

Dataset structure
========================================================



```r
head(ratings,1)
```

```
  userId movieId rating timestamp
1      1       6      2 980730861
```

```r
head(movies,1)
```

```
  movieId            title                                      genres
1       1 Toy Story (1995) Adventure|Animation|Children|Comedy|Fantasy
```

App UI
========================================================
Here's the screenshot of App UI
