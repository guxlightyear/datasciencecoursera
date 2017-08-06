complete <- function(directory, id = 1:332) {
  # Create initial empty data frame
  values <- data.frame(
    ID=integer(),
    nobs=integer()
  )
  
  print(values)
  
  # Read each file, and calculate the number of nobs
  for (x in id) {
    # Read file
    filename <- paste(directory, "/", sprintf("%03d", x), ".csv", sep="")
    
    df <- read.csv(filename, header = TRUE)
    
    # Filter elements where the second or third columns is NA
    sub <- subset(df, (!is.na(df[,2])) & (!is.na(df[,3])))
    
    values <- rbind(values,
          c(x, nrow(sub)))
  }
  
  colnames(values) <- c("ID", "nobs")
  values
}