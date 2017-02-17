
##### Q3- Emissions from 1999 to 2008 in Baltimore City, Maryland by category of types
library("dplyr")
library(lattice)
library("ggplot2")

setwd("~/Shikha/Coursera/Exploratory course4/week4 project")

MarylandSubset<- subset(NEI[,] ,  fips == "24510")
png("plot3.png", height=480, width=680)

ggplot(MarylandSubset, aes(factor(year), Emissions, fill = type)) + 
  geom_bar(stat="identity", position = "dodge") + 
  facet_grid(.~type, scales= "free", space = "free")+
  scale_fill_brewer(palette = "Set3") +
  ggtitle("PM2.5 emissions in Baltimore City, from all sources by 'types'! ") +
  labs(x="Year",y="PM2.5 Emissions") 

dev.off()

