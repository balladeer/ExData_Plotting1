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
png("plot2.png")  # Default height and width are correct for assignment

# Plot the lines to the png device
plot(data$DateTime, data$Global_active_power, ylab="Global Active Power (kilowatts)", xlab="", type="n")
lines(data$DateTime, data$Global_active_power)

# Turn off the device
dev.off()
