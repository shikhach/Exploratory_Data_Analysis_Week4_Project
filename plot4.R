
##### Q4- Across the United States, how have emissions from coal combustion - related sources changed from 1999–2008?

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

#rm(list=ls())
