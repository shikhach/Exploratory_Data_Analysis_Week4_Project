

##### Q2- Emissions from 1999 to 2008 in Baltimore City, Maryland
library("dplyr")
library(lattice)
library("ggplot2")

setwd("~/Shikha/Coursera/Exploratory course4/week4 project")

MarylandSubset<- subset(NEI[,] ,  fips == "24510")

emi_M <- aggregate(Emissions ~ year, data= MarylandSubset, sum)
png("plot2.png" , height=480, width=680)

barplot(  (emi_M$Emissions)/10^6 , names.arg= emi_M$year, ylab="PM2.5 Emissions", xlab="Year" , col= "blue", main="PM2.5 Emissions in Baltimore City, MA from all sources! ")

dev.off()


