png(file = "plot4.png")
data <- read.table("household_power_consumption.txt", sep=";", header = TRUE, na.strings = "?")
data$Datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data <- subset(data, Date >= '2007-02-01' & Date <= '2007-02-02')

par(mfrow = c(2,2))

##Plot1
plot(data$Datetime, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

##Plot2
plot(data$Datetime, data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

##Plot3
plot(data$Datetime, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(data$Datetime, data$Sub_metering_2, type = "l", xlab = "", ylab = "Energy sub metering", col = "Red")
points(data$Datetime, data$Sub_metering_3, type = "l", xlab = "", ylab = "Energy sub metering", col = "Blue")
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", cex = 0.75)

##Plot4
plot(data$Datetime, data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global Reactive Power")

dev.off()