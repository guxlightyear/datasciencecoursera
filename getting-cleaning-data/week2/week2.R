library(jsonlite)
library(httr)
library(httpuv)

q1 <- function() {
  oauth_endpoints("github")
  myapp <- oauth_app(appname = "Cleansing_cleaning_data",
                     key = "7dcc4ad31fab63ccf30d",
                     secret = "fa193767c3f589d6e381b12896e421b52b62a245")
  
  
  github_token <- oauth2.0_token(oauth_endpoints("github"), myapp, cache=FALSE)
  
  gtoken <- config(token = github_token)
  req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
  
  stop_for_status(req)
  
  json1 = content(req)
  
  gitDF = jsonlite::fromJSON(jsonlite::toJSON(json1))
  
  gitDF[gitDF$name=="datasharing",]$created_at
}



downloadDataQ2 <- function() {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
  destFile <- "week1data-q2.csv"
  download.file(url, destfile = destFile, method = "curl")
  
  data <- read.table(destFile, sep = ",", header=TRUE)
} 

library(sqldf)
q2 <- function() {
  acs <- downloadDataQ2()
}

q4 <- function() {
  con = url("http://biostat.jhsph.edu/~jleek/contact.html")
  htmlCode = readLines(con)
  close(con)
  
  sapply(htmlCode[c(10,20,30,100)],nchar)
}

downloadDataQ5 <- function() {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
  destFile <- "week2data-q5.csv"
  download.file(url, destfile = destFile, method = "curl")
  
  data <- read.fwf(destFile, widths = c(-28,4), skip = 4)
  
  sum(data)
}