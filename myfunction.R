add2 <- function(x, y) {
  x + y
}

above10 <- function(x) {
  x[x > 10]
}

above <- function(vector, x = 10) {
  vector[vector > x]
}

column_mean <- function(y) {
  nc <- ncol(y)
  means <- numeric(nc)
  for (i in 1:nc) {
    means[i] <- mean(y[,i])
  }
  means
}