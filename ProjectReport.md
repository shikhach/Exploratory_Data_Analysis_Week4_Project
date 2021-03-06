Exploratory Data Analysis - Coursera Project 2
============================================

**NOTE: The answers to the questions are at the bottom of this document.**

# Introduction

Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM2.5. This database is known as the National Emissions Inventory (NEI). You can read more information about the NEI at the EPA National [Emissions Inventory web site](http://www.epa.gov/ttn/chief/eiinformation.html).

For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course of the entire year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.

# Data

The data for this assignment are available from the course web site as a single zip file:

* [Data for Peer Assessment [29Mb]](https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip)

The zip file contains two files:

PM2.5 Emissions Data (`summarySCC_PM25.rds`): This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year. Here are the first few rows.
````
##     fips      SCC Pollutant Emissions  type year
## 4  09001 10100401  PM25-PRI    15.714 POINT 1999
## 8  09001 10100404  PM25-PRI   234.178 POINT 1999
## 12 09001 10100501  PM25-PRI     0.128 POINT 1999
## 16 09001 10200401  PM25-PRI     2.036 POINT 1999
## 20 09001 10200504  PM25-PRI     0.388 POINT 1999
## 24 09001 10200602  PM25-PRI     1.490 POINT 1999
````

* `fips`: A five-digit number (represented as a string) indicating the U.S. county
* `SCC`: The name of the source as indicated by a digit string (see source code classification table)
* `Pollutant`: A string indicating the pollutant
* `Emissions`: Amount of PM2.5 emitted, in tons
* `type`: The type of source (point, non-point, on-road, or non-road)
* `year`: The year of emissions recorded

Source Classification Code Table (`Source_Classification_Code.rds`): This table provides a mapping from the SCC digit strings int he Emissions table to the actual name of the PM2.5 source. The sources are categorized in a few different ways from more general to more specific and you may choose to explore whatever categories you think are most useful. For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.

You can read each of the two files using the `readRDS()` function in R. For example, reading in each file can be done with the following code:

````
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
````

as long as each of those files is in your current working directory (check by calling `dir()` and see if those files are in the listing).

# Assignment

The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine particulate matter pollution in the United states over the 10-year period 1999–2008. You may use any R package you want to support your analysis.

## Making and Submitting Plots

For each plot you should

* Construct the plot and save it to a PNG file.
* Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. Your code file should include code for reading the data so that the plot can be fully reproduced. You should also include the code that creates the PNG file. Only include the code for a single plot (i.e. plot1.R should only include code for producing plot1.png)
* Upload the PNG file on the Assignment submission page
* Copy and paste the R code from the corresponding R file into the text box at the appropriate point in the peer assessment.



We now load the NEI and SCC data frames from the .rds files.

```
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
```

## Questions

You must address the following questions and tasks in your exploratory analysis. For each question/task you will need to make a single plot. Unless specified, you can use any plotting system in R to make your plot.

### Question 1

Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008. Upload a PNG file containing your plot addressing this question.

```library("dplyr")
library(lattice)


setwd("~/Shikha/Coursera/Exploratory course4/week4 project")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

emi <- aggregate(Emissions ~ year, data= NEI, sum)
png("plot1.png", height=480, width=680)

barplot(  (emi$Emissions)/10^6 , names.arg= emi$year, ylab="PM2.5 Emissions", xlab="Year", main= "Total emissions from PM2.5 in the United States" , col= "navy blue")
dev.off()
```
![plot of chunk plot1](plot1.png) 

**Conclusion

As we can see from the plot, total emissions have decreased in the US from 1999 to 2008.

### Question 2

Have total emissions from PM2.5 decreased in the  Baltimore City, Maryland ( fips == 24510) from 1999 to 2008? Use the base plotting system to make a plot answering this question.

```
library("dplyr")
library(lattice)
library("ggplot2")

setwd("~/Shikha/Coursera/Exploratory course4/week4 project")

MarylandSubset<- subset(NEI[,] ,  fips == "24510")

emi_M <- aggregate(Emissions ~ year, data= MarylandSubset, sum)
png("plot2.png" , height=480, width=680)

barplot(  (emi_M$Emissions)/10^6 , names.arg= emi_M$year, ylab="PM2.5 Emissions", xlab="Year" , col= "blue", main="PM2.5 Emissions in Baltimore City, MA from all sources! ")

dev.off()

```
![plot of chunk plot1](plot2.png) 

**Conclusion

Overall total emissions from PM2.5 have decreased in Baltimore City, Maryland from 1999 to 2008.

### Question 3

Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

```

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

```
![plot of chunk plot1](plot3.png) 

**Conclusion

The `non-road`, `nonpoint`, `on-road` source types have all seen decreased emissions overall from 1999-2008 in Baltimore City.

**Which have seen increases in emissions from 1999–2008?**

The `point` source saw a slight increase overall from 1999-2008. Also note that the `point` source saw a significant increase until 2005 at which point it decreases again by 2008 to just above the starting values. 

(Note that I used a log scale on Emissions)


### Question 4

Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?


```
library("ggplot2")
library (sqldf)

setwd("~/Shikha/Coursera/Exploratory course4/week4 project")

SCC_coal_subset <- SCC[grepl("coal", SCC$EI.Sector, ignore.case=TRUE),]
dfr<- sqldf("select *from NEI join SCC_coal_subset where  NEI.SCC= SCC_coal_subset.SCC ")

png("plot4.png", height=480, width=680)

ggplot(dfr, aes(factor(year), Emissions)) + 
  geom_bar(stat="identity", position = "dodge", fill= " navy blue") +
  scale_fill_brewer(palette = "Set1") +
  labs(x="Year",y="PM2.5 Emissions") + 
  ggtitle("PM2.5 emissions across U.S from coal combustion ") 

dev.off()

```
![plot of chunk plot1](plot4.png) 

**Conclusion

Emissions from coal combustion related sources have decreased from 1999-2008.

Eg. Emissions from coal combustion related sources have decreased by about 1/3 from 1999-2008!


### Question 5

How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

```library("dplyr")
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
```
![plot of chunk plot1](plot5.png) 

**Conclusion

Emissions from motor vehicle sources have dropped from 1999-2008 in Baltimore City!


### Question 6

Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == 06037). Which city has seen greater changes over time in motor vehicle emissions?

```
library("dplyr")
library("ggplot2")

setwd("~/Shikha/Coursera/Exploratory course4/week4 project")

Balt_Cal_motor<- subset(NEI[,] ,  fips %in% c("24510" ,"06037") & type== "ON-ROAD")

Balt_Cal_motor$City[fips =="24510"] <- "Baltimore City, MD"
Balt_Cal_motor$City[fips == "06037"] <- "Los Angeles City, CA"

attach(Balti_Cal_motor_Subset)

png("plot6.png", height=480, width=680)

ggplot(Balt_Cal_motor, aes(x= factor(year), y= Emissions, fill= City)) + 
  geom_bar(stat="identity") + 
  facet_grid( City ~. , scales= "free") +
  scale_fill_brewer(palette = "Set2") +
  ggtitle("PM2.5 emissions in Baltimore and California from motor vehicles ") +
  labs(x="Year", y="PM2.5 Emissions")


dev.off()
```
![plot of chunk plot1](plot6.png) 

**Conclusion

Los Angeles County has seen the greatest changes over time in motor vehicle emissions.
