library(future)
library(ambiorix)
library(coro)
library(httr)
library(RPostgres)
library(promises)
library(yaml)
library(dplyr)
library(tidyr)
library(lubridate)
library(jsonlite)
library(rworldmap)
library(sp)


plan(multisession)


source("./router/user-info.R")
source("./helpers/connect_db.R")
source("./jobs/job.R")
source("./jobs/fetchAndStoreData.R")
source("./jobs/setupDatabase.R")



PORT <- 1000L
localhost <- "127.0.0.1"
app <- Ambiorix$new()

app$use(function(req, res) {
  res$header("Access-Control-Allow-Origin", "*")
  res$header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
  res$header("Access-Control-Allow-Headers", "Content-Type, Authorization")
})

app$options("*", function(req, res) {
  res$header("Access-Control-Allow-Origin", "*")
  res$header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
  res$header("Access-Control-Allow-Headers", "Content-Type, Authorization")
  res$send()
})

# Routers to get user-info
app$use(router)

promises::promise_all(job())



app$start(port = PORT, host = localhost)



