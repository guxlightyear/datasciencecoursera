NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

coalSources <- SCC[grep("coal",SCC$Short.Name,ignore.case = TRUE),"SCC"]
onlyCoal<- NEI[which(NEI$SCC %in% coalSources),]
g<-ggplot(onlyCoal,aes(year,Emissions))
g <- g+geom_line(stat = "summary",fun.y="sum")+ labs(y="Emissions from coal combustion-related sources",x="Year (1999 - 2008)")
print(g)
# To file
dev.copy(png, "plot4.png")
dev.off()  