rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  outcomeData <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  if (! state %in% outcomeData$State) {
    stop("invalid state")
  } 
  if (! outcome %in% c("heart attack", "heart failure", "pneumonia")) {
    stop("invalid outcome")
  }
  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  dataForState <- outcomeData[outcomeData$State == state,]
  trimmedDataForState <- dataForState[c(2,11,17,23)]
  trimmedDataForState[,2] <- as.numeric(trimmedDataForState[,2])
  trimmedDataForState[,3] <- as.numeric(trimmedDataForState[,3])
  trimmedDataForState[,4] <- as.numeric(trimmedDataForState[,4])
  outcomeColumn <- switch(outcome,
                          "heart attack" = 2,
                          "heart failure" = 3,
                          "pneumonia" = 4)
  
  # Remove NA in the outcome column
  trimmedDataForState <- trimmedDataForState[!is.na(trimmedDataForState[,outcomeColumn]),]
  
  # Sort the data by the correct column and state
  orderedData <- trimmedDataForState[with(trimmedDataForState, order(trimmedDataForState[,outcomeColumn], trimmedDataForState$Hospital.Name)), ]
  

  # Translate things such as best to 1 and worst to the last value
  number <- if (num == "best") {
    1
  } else if (num == "worst") {
    nrow(orderedData)
  } else {
    num
  }
  
  # Return the desired result
  orderedData[number,1]
}
