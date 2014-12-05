# Read in the data  (days we care about are in first 80k lines)
data <- read.table("household_power_consumption.txt", header=T, sep=";", stringsAsFactors=F, na.strings="?", nrows=80000)

# Convert the Date column to Date instances
data["Date"] = as.Date(data$Date, format="%d/%m/%Y")

# Subset to desired days
start_date <- as.Date("2007-02-01")
end_date <- as.Date("2007-02-02")
data <- data[(data$Date >= start_date) & (data$Date <= end_date), ]

# Open PNG graphics device
png("plot1.png")  # Default height and width are correct for assignment

# Plot the histogram to the png device
hist(data$Global_active_power, col='red', main="Global Active Power", xlab="Global Active Power (kilowatts)")

# Turn off the device
dev.off()
