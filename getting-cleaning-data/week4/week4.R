q1 <- function() {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
  destFile <- "week4data-q1.csv"
  download.file(url, destfile = destFile, method = "curl")
  
  data <- read.table(destFile, sep = ",", header=TRUE)
  
  strsplit(names(data), "wgtp")[[123]]
  
  # ""  "15"
}

q2 <- function() {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
  destFile <- "week4data-q2.csv"
  download.file(url, destfile = destFile, method = "curl")
  
  dtGDP <- data.table(read.csv(f, skip = 4, nrows = 215, stringsAsFactors = FALSE))
  dtGDP <- dtGDP[X != ""]
  dtGDP <- dtGDP[, list(X, X.1, X.3, X.4)]
  setnames(dtGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", 
                                                 "Long.Name", "gdp"))
  gdp <- as.numeric(gsub(",", "", dtGDP$gdp))
  
  mean(gdp, na.rm = TRUE)
  
  # 377652.4
}

q3 <- function() {
  countryNames <- dtGDP$Long.Name
  
  isUnited <- grepl("^United", countryNames)
  summary(isUnited)
}

q4 <- function() {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
  destFile <- "week4data-q41.csv"
  download.file(url, destfile = destFile, method = "curl")
  
  dtGDP <- data.table(read.csv(f, skip = 4, nrows = 215, stringsAsFactors = FALSE))
  dtGDP <- dtGDP[X != ""]
  dtGDP <- dtGDP[, list(X, X.1, X.3, X.4)]
  setnames(dtGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", 
                                                 "Long.Name", "gdp"))
  
  
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
  destFile <- "week4data-q42.csv"
  download.file(url, destfile = destFile, method = "curl")
  
  dtEducation <- data.table(read.csv(destFile, header=TRUE))
  
  merged <- merge(x = dtGDP, y = dtEducation, by = "CountryCode", all = TRUE)
  
  isFiscalYearEnd <- grepl("fiscal year end", tolower(merged$Special.Notes))
  isJune <- grepl("june", tolower(merged$Special.Notes))
  
  table(isFiscalYearEnd, isJune)
  
  length(merged[isFiscalYearEnd & isJune, Special.Notes])
  
  # 13
}

q5 <- function() {
  library(quantmod)
  amzn = getSymbols("AMZN",auto.assign=FALSE)
  sampleTimes = index(amzn)
  
  # How many values collected in 2012?
  table(grepl("2012-", sampleTimes))
  # 250
  
  # How many values collected on Mondays in 2012?
  sum(sapply(sampleTimes, function(dateAsString) { date <- as.Date(dateAsString); weekdays(date) == "Monday" & year(date) == 2012} ))
  # 47

}