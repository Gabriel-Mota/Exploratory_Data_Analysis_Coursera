## Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Create png file to store the graph
png(file = "plot2.png")

##Question 2
##Have total emissions from PM2.5 decreased in the Baltimore City, Maryland from 1999 to 2008?

##Subset data to registries from Maryland only (fips == "24510")
mary <- subset(NEI, fips == "24510")

##Sum of total PM2.5 emissions by year for subset mary
sum1 <- aggregate(mary$Emissions, list(year = mary$year), sum)

##Plot of total PM2.5 emission
plot(sum1$year, sum1$x, type = "b", xaxt = 'n', lwd = 5, xlab = "Year", ylab = "Emissions", main = "Emissions by Year in Baltimore City, Maryland", col = "Red")
axis(1, at = sum1$year)

## Eemissions from PM2.5 in Baltimore City, Maryland have decreased from '99 to '02,
##increase from '02 to '05 and decreased again from '05 to '08

dev.off()