

downloadDataQ1 <- function() {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
  destFile <- "week3data-q1.csv"
  download.file(url, destfile = destFile, method = "curl")
  
  data <- read.table(destFile, sep = ",", header=TRUE)
} 

q1 <- function(data) {
  agricultureLogical <- with(data, ACR==3 & AGS==6)
  which(agricultureLogical)
}

downloadDataQ2 <- function() {
  library(jpeg)
  
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
  destFile <- "week3data-q2.jpg"
  download.file(url, destfile = destFile, method = "curl")
  
  jpg <- readJPEG(destFile, native=TRUE)
}

q2 <- function(img) {
  quantile(img, probs = c(0.3, 0.8))
}


downloadDataQ31 <- function() {
  library(data.table)
  
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
  destFile <- "week3data-q3-1.csv"
  download.file(url, destfile = destFile, method = "curl")
  
  data <- data.table(read.csv(destFile, skip = 4, nrows=215))
  data <- data[X != ""]
  data <- data[, list(X, X.1, X.3, X.4)]
  setnames(data, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", 
                                                 "Long.Name", "gdp"))
  
  data
}

downloadDataQ32 <- function() {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
  destFile <- "week3data-q3-2.csv"
  download.file(url, destfile = destFile, method = "curl")
  
  data <- read.csv(destFile, sep = ",", header=TRUE)
}

q3 <- function(dtGDP, dtEdu) {
  total <- inner_join(dtGDP,dtEdu,by=c("CountryCode"))
  total <- filter(total, !is.na(rankingGDP))
  print(nrow(total))
  
  sorted_total <- arrange(total, desc(rankingGDP))
  countries <- select(sorted_total, Long.Name.x)
}

q4 <- function(dtGDP, dtEdu) {
  total <- inner_join(dtGDP,dtEdu,by=c("CountryCode"))
  total <- filter(total, !is.na(rankingGDP))
  
  total %>%
    group_by(Income.Group) %>%
    summarise(avg = mean(rankingGDP))
}

q5 <- function(dtGDP, dtEdu) {
  total <- inner_join(dtGDP,dtEdu,by=c("CountryCode"))
  total <- filter(total, !is.na(rankingGDP))
  
  breaks <- quantile(total$rankingGDP, probs = seq(0, 1, 0.2), na.rm = TRUE)
  total %>%
    
}