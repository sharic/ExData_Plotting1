# Shari Cartun
# plot1.R

# load Electric Power Consumption data into R
power <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)

# convert Date and Time fields to applicable datatypes
power$Date <- as.Date(power$Date, "%d/%m/%Y")
power$Time <- strptime(power$Time, "%H:%M:%S")

# convert character fields to numeric
power$Global_active_power <- suppressWarnings(as.numeric(power$Global_active_power))
power$Global_reactive_power <- suppressWarnings(as.numeric(power$Global_reactive_power))
power$Voltage <- suppressWarnings(as.numeric(power$Voltage))
power$Global_intensity <- suppressWarnings(as.numeric(power$Global_intensity))
power$Sub_metering_1 <- suppressWarnings(as.numeric(power$Sub_metering_1))
power$Sub_metering_2 <- suppressWarnings(as.numeric(power$Sub_metering_2))

# subset the data for 2/1/2007 and 2/2/2007
subPower <- power[(power$Date == '2007-02-01') | ((power$Date == '2007-02-02')),]

### Create PLOT 1
par(mfrow = c(1,1)) 
hist(subPower$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()

##