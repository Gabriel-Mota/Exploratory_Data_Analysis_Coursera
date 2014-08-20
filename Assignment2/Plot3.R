## Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Create png file to store the graph
png(file = "plot3.png")

## Question 3
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad)
## variable, which of these four sources have seen decreases in emissions from 1999–2008 for
## Baltimore City? Which have seen increases in emissions from 1999–2008?

##Subset data to registries from Maryland only (fips == "24510")
mary <- subset(NEI, fips == "24510")

##Aggregate Sum of total PM2.5 emissions by type for each year, for subset mary
sum1 <- aggregate(mary$Emissions, list(type = mary$type, year = mary$year), sum)

##Plot of total PM2.5 emission by year, for each type
library(ggplot2)
ggplot(aes(x = year, y = x, color = type), data = sum1) + geom_point() + geom_line() + labs(title = "Total PM2.5 Emmissions by Year for each Type") + ylab("Emissions")

## The Emissions types (nonroad, nonpoint and onroad) have all decreased over the years
## only the type (point) has increased from 1999 to 2005 and decresead from 2005 to 2008

dev.off()