# Shari Cartun
# plot2.R

# load Electric Power Consumption data into R
power <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)

# convert Date field to Date datatype
power$Date <- as.Date(power$Date, "%d/%m/%Y")

# convert character fields to numeric
power$Global_active_power <- suppressWarnings(as.numeric(power$Global_active_power))
power$Global_reactive_power <- suppressWarnings(as.numeric(power$Global_reactive_power))
power$Voltage <- suppressWarnings(as.numeric(power$Voltage))
power$Global_intensity <- suppressWarnings(as.numeric(power$Global_intensity))
power$Sub_metering_1 <- suppressWarnings(as.numeric(power$Sub_metering_1))
power$Sub_metering_2 <- suppressWarnings(as.numeric(power$Sub_metering_2))

# subset the data for 2/1/2007 and 2/2/2007
subPower <- power[(power$Date == '2007-02-01') | ((power$Date == '2007-02-02')),]

# concatenate the Date and Time variables into 1 column variable of type POSIXlt
#subPower$DateTime <- paste(subPower$Date,subPower$Time, sep=" ")
#subPower$DateTime <- strptime(subPower$DateTime, format="%Y-%m-%d %H:%M:%S")
subPower$DateTime <- strptime(paste(subPower$Date,subPower$Time, sep=" "), format="%Y-%m-%d %H:%M:%S")

### Create PLOT 2
par(mfrow = c(1,1))
plot(subPower$DateTime, subPower$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)",cex = .03)
lines(subPower$DateTime, subPower$Global_active_power)
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()

##