png(file = "plot1.png")

## Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Question 1
##Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?

##Sum of total PM2.5 emissions by year
sum1 <- aggregate(NEI$Emissions, list(year = NEI$year), sum)

##Plot of total PM2.5 emission
plot(sum1$year, sum1$x, type = "b", xaxt = 'n', lwd = 5, xlab = "Year", ylab = "Emissions", main = "Emissions by Year", col = "Red")
axis(1, at = sum1$year)

## As can be seen, the total emissions from PM2.5 alwasys decreased from 1999 to 2008

dev.off()