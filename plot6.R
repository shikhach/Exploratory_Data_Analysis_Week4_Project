# Q6- Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in 
# Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

library("dplyr")
library("ggplot2")

setwd("~/Shikha/Coursera/Exploratory course4/week4 project")

Balt_Cal_motor<- subset(NEI[,] ,  fips %in% c("24510" ,"06037") & type== "ON-ROAD")

# Balti_Cal_motor_Subset<- aggregate(Emissions ~ year,  data= Balt_Cal_motor, factor(City), FUN=sum)
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

