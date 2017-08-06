corr <- function(directory, threshold = 0) {
  
  correlations <- c()
  
  # For each file
  for (file in 1:332) {
    # Read file
    filename <- paste(directory, "/", sprintf("%03d", file), ".csv", sep="")
    
    df <- read.csv(filename, header = TRUE)
    
    # Filter elements where the second or third columns is NA
    sub <- subset(df, (!is.na(df[,2])) & (!is.na(df[,3])))
    
    if (nrow(sub) >= threshold) {
      correlations <- c(correlations, cor(sub[,2], sub[,3]))
    }
  }
  
  correlations
}