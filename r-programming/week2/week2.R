allvalues <- function(directory, id=1:332) {
  
  # Create an empty data frame
  values <- data.frame(
    Date=as.Date(character()),
    sulfate=double(),
    nitrate=double(),
    ID=integer()
  )
  
  # Apend the values from all the files in the range
  for (x in id) {
    filename <- paste(directory, "/", sprintf("%03d", x), ".csv", sep="")
    morevalues <- read.csv(filename, header = TRUE)
    values <- rbind(values, morevalues)
  }
  
  values
}

pollutantmean <- function(directory, pollutant, id=1:332) {
  mean_pollutant <- 0
  
  for (x in id) {
    filename <- paste(directory, "/", sprintf("%03d", x), ".csv", sep="")
    values <- read.table(filename)
    print(values)
  }
}