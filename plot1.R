# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
# make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

library("dplyr")
library(lattice)
library("ggplot2")

setwd("~/Shikha/Coursera/Exploratory course4/week4 project")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

emi <- aggregate(Emissions ~ year, data= NEI, sum)
png("plot1.png", height=480, width=680)

barplot(  (emi$Emissions)/10^6 , names.arg= emi$year, ylab="PM2.5 Emissions", xlab="Year", main= "Total emissions from PM2.5 in the United States" , col= "navy blue")
dev.off()

