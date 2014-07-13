# Shari Cartun
# plot1.R

# load Electric Power Consumption data into R
power <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)

# convert Date, Time and numeric fields to applicable datatypes
power <- suppressWarnings(transform(power, Date=as.Date(power$Date, "%d/%m/%Y"), Time=strptime(power$Time, "%H:%M:%S"),
                                    Global_active_power=as.numeric(power$Global_active_power),
                                    Global_reactive_power=as.numeric(power$Global_reactive_power),
                                    Voltage=as.numeric(power$Voltage),
                                    Global_intensity=as.numeric(power$Global_intensity),
                                    Sub_metering_1=as.numeric(power$Sub_metering_1),
                                    Sub_metering_2=as.numeric(power$Sub_metering_2)))

# subset the data for 2/1/2007 and 2/2/2007
subPower <- power[(power$Date == '2007-02-01') | ((power$Date == '2007-02-02')),]

### Create PLOT 1
par(mfrow = c(1,1)) 
hist(subPower$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()

##