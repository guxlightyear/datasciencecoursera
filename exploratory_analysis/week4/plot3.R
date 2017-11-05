NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)
sub_emissions<- subset(NEI,fips="24510")
g<-ggplot(sub_emissions,aes(year,Emissions,color=type))
g+geom_line(stat = "summary",fun.y="sum")+ labs(y="Emissions for Baltimore City ",x="Year (1999 - 2008)")

# To file
dev.copy(png, "plot3.png")
dev.off()  


# NONPOINT decreased the most, POINT and Non-road have decreased slighty, and on-road, is more or less stable