##### Q5- How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
library("dplyr")
library("ggplot2")

setwd("~/Shikha/Coursera/Exploratory course4/week4 project")

Balt_vehi_set<- subset(NEI[,] ,  fips == "24510" & type == "ON-ROAD")
Balt_vehi_set_aggr <- aggregate(Emissions ~ year, data=Balt_vehi_set, FUN=sum)

png("plot5.png", height=480, width=680)

ggplot(Balt_vehi_set_aggr, aes(factor(year), Emissions)) + 
  geom_bar(stat="identity", position = "dodge", fill= " navy blue") + 
  scale_fill_brewer(palette = "Set1") +
  ggtitle("Total PM2.5 emissions from motor vehicle sources in Baltimore City ") +
  labs(x="Year",y="Total PM2.5 Emissions") 

dev.off()