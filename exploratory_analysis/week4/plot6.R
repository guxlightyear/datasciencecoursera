NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

motorSources <- SCC[grep("motor",SCC$Short.Name,ignore.case = TRUE),"SCC"]

citiesOfInterest = c("24510", "06037") # Baltimore and LA

motorEmisions<- subset(NEI, fips %in% citiesOfInterest & SCC %in% motorSources)
  #NEI[which(NEI$SCC %in% motorSources & NEI$fips %in% citiesOfInterest),]

g <- ggplot(motorEmisions,aes(year, Emissions, color = fips))
g <- g + geom_line(stat = "summary",fun.y="sum") + labs(y="Emissions from motor combustion-related sources in several cities",
                                                      x="Year (1999 - 2008)")
g <- g + scale_color_discrete(name = "City", label = c("Los Angeles", "Baltimore"))
print(g)

# To file
dev.copy(png, "plot6.png")
dev.off()  

# LA are way higher