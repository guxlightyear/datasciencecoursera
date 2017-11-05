NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Create matrix for year | total emision (4 years => 4 rows)
emisionsMatrix <- matrix(nrow=4, ncol=2)

# First column: years
years <- levels(as.factor(NEI$year))
emisionsMatrix[,1] = years

# Second column: totals
for (i in seq_along(years)) {
  totalForYear <- sum(NEI[which(NEI$year == years[i]), 4])
  emisionsMatrix[i, 2] = totalForYear
}

# Coerce into dataframe to set meaningful column names and printing purposes
emisionsDF <- data.frame(emisionsMatrix, stringsAsFactors = F)
names(emisionsDF) <- c("year", "totalEmisions")
emisionsDF$totalEmisions <- as.numeric(emisionsDF$totalEmisions)


# Print the plot
plot(emisionsDF)
lines(emisionsDF, col="red")

# To file
dev.copy(png, "plot1.png")
dev.off()  


# Answer: yes, they have decreased