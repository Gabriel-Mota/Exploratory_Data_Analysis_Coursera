## Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Create png file to store the graph
png(file = "plot4.png")

## Question 4
## Across the United States, how have emissions from coal combustion-related sources
## changed from 1999–2008?

##Extract from SCC dataset all the registries with the word "Coal" on EI.Sector
a<-grep(".*[c,C]oal.*", SCC$EI.Sector, value = TRUE)

##Select from the SCC dataset only the SCC codes that match with dataset a
j <- subset(SCC, EI.Sector %in% a, select = SCC)

##Convert the integers SCC codes in j dataset to strings
l <- NULL
for(i in 1:length(j[,1])){
  l[i] = toString(j[i,1])
}

##Subset the NEI dataset to present only the registries with the SCC codes from dataset j
new <- subset(NEI, NEI$SCC %in% l)

##Aggregate Sum of total PM2.5 emissions for each year, for subset new
sum1 <- aggregate(new$Emissions, list(year = new$year), sum)

##Plot of total PM2.5 emission by year, for each type
par(cex.main = 1)
plot(sum1$year, sum1$x, type = "b", xaxt = 'n', lwd = 5, xlab = "Year", ylab = "Emissions", main = "Emissions from Coal Combustion-Related Sources by Year", col = "Red")
axis(1, at = sum1$year)

## The Emissions from coal combustion-related sources in the United States,
## have been decreasing. From 2002 to 2005 there is a small increase, followed by a very big
## decrease from 2005 to 2008

dev.off()