source("rankhospital.R")

rankall <- function(outcome, num = "best") {
  ## Read outcome data
  outcomeData <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

  ## Check that the outcome is valid
  if (! outcome %in% c("heart attack", "heart failure", "pneumonia")) {
    stop("invalid outcome")
  }
  
  
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  # For each state, find the hospital of the given rank
  allStates <- sort(unique(outcomeData$State))
  
  result <- data.frame(
    hospital = sapply(allStates, function(state) {rankhospital(state, outcome, num)}),
    state = allStates
  )
  
  # return the desired result
  result
}
