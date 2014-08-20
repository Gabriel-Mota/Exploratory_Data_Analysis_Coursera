## Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Create png file to store the graph
png(file = "plot6.png")

## Question 6
## Which city has seen greater changes over time in motor vehicle emissions?
## Baltimore City or Los Angeles

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

##Subset data to registries from Los Angeles County, California (fips == "06037")
la <- subset(NEI, fips == "06037")

##Subset the mary dataset to present only the registries with the SCC codes from dataset j
new <- subset(mary, mary$SCC %in% l)

##Subset the la dataset to present only the registries with the SCC codes from dataset j
new2 <- subset(la, la$SCC %in% l)

##Create new dataset with new and new2 datasets binded
new3 <- rbind(new, new2)

##Aggregate Sum of total PM2.5 emissions by fips for each year, for subset new3
sum1 <- aggregate(new3$Emissions, list(fips = new3$fips, year = new3$year), sum)

##Change the column name fips to City
names(sum1)[1] <- "City"

##Change the SCC code "06037" to "Los Angeles"
sum1$City[sum1$City=="06037"] <- "Los Angeles"

##Change the SCC code "24510" to "Baltimore"
sum1$City[sum1$City=="24510"] <- "Baltimore"

##Plot of total PM2.5 emission by year, for each type
ggplot(aes(x = year, y = x, color = City), data = sum1) + geom_point() + geom_line() + labs(title = "Total PM2.5 Emmissions from Motor Vehicles") + ylab("Emissions")

## Los Angeles was definetly the city that recorded the biggest changes in motor vehicle
## emissions. When analysed on the same scale, Baltimore almost has no peaks.

dev.off()