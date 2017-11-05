NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

motorSources <- SCC[grep("motor",SCC$Short.Name,ignore.case = TRUE),"SCC"]
motorInBaltimore<- NEI[which(NEI$SCC %in% motorSources & NEI$fips=="24510"),]
g<-ggplot(motorInBaltimore,aes(year,Emissions))
g <- g+geom_line(stat = "summary",fun.y="sum")+ labs(y="Emissions from motor combustion-related sources in Baltimore",x="Year (1999 - 2008)")
print(g)

# To file
dev.copy(png, "plot5.png")
dev.off()  

# Grown and gone down to similar levels