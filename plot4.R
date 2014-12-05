# Read in the data  (days we care about are in first 80k lines)
data <- read.table("household_power_consumption.txt", header=T, sep=";", stringsAsFactors=F, na.strings="?", nrows=80000)

# Convert the Date column to Date instances
data["Date"] = as.Date(data$Date, format="%d/%m/%Y")

# Subset to desired days
start_date <- as.Date("2007-02-01")
end_date <- as.Date("2007-02-02")
data <- data[(data$Date >= start_date) & (data$Date <= end_date), ]

# Create a single DateTime column
data["DateTime"] = as.POSIXct(strptime(paste(data$Date, data$Time, sep=" "), format="%Y-%m-%d %H:%M:%S"))

# Open PNG graphics device
png("plot4.png")  # Default height and width are correct for assignment

# Configure the grid of plots
par(mfrow = c(2,2))  # Fill row-wise

# Graph the Global Active Power plot
plot(data$DateTime, data$Global_active_power, xlab="", ylab="Global Active Power", type="n")
lines(data$DateTime, data$Global_active_power)

# Graph the Voltage plot
plot(data$DateTime, data$Voltage, xlab="datetime", ylab="Voltage", type="n")
lines(data$DateTime, data$Voltage)

# Graph the sub-metering plot
plot(data$DateTime, data$Sub_metering_1, ylab="Energy sub metering", xlab="", type="n")
lines(data$DateTime, data$Sub_metering_1, col="black")
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")

# Add the sub-metering legend
legend("topright",
       col=c("black", "red", "blue"),
       lwd=c(2.5,2.5),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty="n")

# Graph the Global Reactive Power plot
plot(data$DateTime, data$Global_reactive_power, ylab="Global_reactive_power", xlab="datetime", type="n")
lines(data$DateTime, data$Global_reactive_power)

# Turn off the device
dev.off()
