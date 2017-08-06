best <- function(state, outcome) {
  ## Read outcome data
  outcomeData <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  if (! state %in% outcomeData$State) {
    stop("invalid state")
  } 
  if (! outcome %in% c("heart attack", "heart failure", "pneumonia")) {
    stop("invalid outcome")
  }
  
  ## Return hospital name in that state with lowest 30-day death-rate
  dataForState <- outcomeData[outcomeData$State == state,]
  outcomeColumn <- switch(outcome,
                          "heart attack" = 11,
                          "heart failure" = 17,
                          "pneumonia" = 23)
  minValue <- min(as.numeric(dataForState[,outcomeColumn]), na.rm = TRUE)
  hospitalsWithMinValue <- dataForState[dataForState[,outcomeColumn] == sprintf("%.1f", minValue),]
  hospitalsWithMinValue$Hospital.Name
}