## Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Create png file to store the graph
png(file = "plot5.png")

## Question 5
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

##Extract from SCC dataset all the registries with the word "Mobile" on EI.Sector
a<-grep(".*[m,M]obile.*", SCC$EI.Sector, value = TRUE)

##Select from the SCC dataset only the SCC codes that match with dataset a
j <- subset(SCC, EI.Sector %in% a, select = SCC)

##Convert the integers SCC codes in j dataset to strings
l <- NULL
for(i in 1:length(j[,1])){
  l[i] = toString(j[i,1])
}

##Subset data to registries from Maryland only (fips == "24510")
mary <- subset(NEI, fips == "24510")

##Subset the NEI dataset to present only the registries with the SCC codes from dataset j
new <- subset(mary, mary$SCC %in% l)

##Aggregate Sum of total PM2.5 emissions for each year, for subset new
sum1 <- aggregate(new$Emissions, list(year = new$year), sum)

##Plot of total PM2.5 emission by year, for each type
par(cex.main = 1)
plot(sum1$year, sum1$x, type = "b", xaxt = 'n', lwd = 5, xlab = "Year", ylab = "Emissions", main = "Emissions from Motor Vehicle Sources in Baltimore, Maryland", col = "Red")
axis(1, at = sum1$year)

## The Emissions from motor vehicle sources in Baltimore city, decreased
## from 1999 to 2002, followed by a slight increse from 2002 to 2005, and then a more
## significant increase from 2005 to 2008

dev.off()