downloadDataQ1 <- function() {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
  destFile <- "week1data-q1.csv"
  download.file(url, destfile = destFile, method = "curl")
  
  data <- read.table(destFile, sep = ",", header=TRUE)
} 

q1 <- function (data) {
  # VAL is an enum. 24 = > 1000000
  nrow(subset(data, VAL == 24))
}



downloadDataQ3 <- function() {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
  destFile <- "week1data-q3.xml"
  download.file(url, destfile = destFile, method = "curl")
  
  library(xlsx)
  colIndex <- 7:15
  rowIndex <- 18:23
  dat <- read.xlsx(destFile, sheetIndex = 1, colIndex=colIndex, rowIndex=rowIndex)
  
} 

q3 <- function (dat) {
  sum(dat$Zip*dat$Ext,na.rm=T)
}



downloadDataQ4 <- function() {
  library(XML)
  url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
  doc <- xmlTreeParse(url, useInternal=TRUE)
} 

q4 <- function(doc) {
  rootNode <- xmlRoot(doc)
  zipCodes <- xpathSApply(rootNode, "//zipcode[.=21231]", xmlValue)
  length(zipCodes)
}



downloadDataQ5 <- function() {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
  destFile <- "week1data-q5.csv"
  download.file(url, destfile = destFile, method = "curl")
  
  library("data.table")
  data <- fread(destFile, sep = ",", header=TRUE)
}

q5 <- function (DT) {
  print(system.time(sapply(split(DT$pwgtp15,DT$SEX),mean)))
  print(system.time({ DT[DT$SEX==1, mean(pwgtp15)]; DT[DT$SEX==2, mean(pwgtp15)] }))
  print(system.time(DT[,mean(pwgtp15),by=SEX]))
  print(system.time(tapply(DT$pwgtp15,DT$SEX,mean)))
  print(system.time({ mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)}))
  print(system.time(mean(DT$pwgtp15,by=DT$SEX)))
}



