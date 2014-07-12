# Shari Cartun
# plot4.R

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
subPower$DateTime <- strptime(paste(subPower$Date,subPower$Time, sep=" "), format="%Y-%m-%d %H:%M:%S")

# create a numeric column from the POSIXlt DateTime variable
subPower <- cbind(subPower, DateTimeNum=as.numeric(subPower$DateTime))

### Create PLOT 4
png(file="plot4.png",width=480,height=480)
par(mfrow = c(2,2)) 

# topleft plot
plot(subPower$DateTime, subPower$Global_active_power, xlab="", ylab="Global Active Power", cex.lab=1, cex = .03, axes=F)
lines(subPower$DateTime, subPower$Global_active_power)
box()
axis(side=2, las=0, lwd=1, cex.axis=.9, tck=-.05)
axis(side=1, las=0, lwd=1, cex.axis=.9, tck=-.05, at=c(1170306000,1170392400,1170478740), labels=c("Thu","Fri","Sat"))

# topright plot
plot(subPower$DateTime, subPower$Voltage, xlab="datetime", ylab="Voltage", cex.lab=1, cex = .03, axes=F)
lines(subPower$DateTime, subPower$Voltage)
box()
axis(side=2, las=0, lwd=1, cex.axis=.9, tck=-.05, at=c(234,236,238,240,242,244,246), labels=c("234","","238","","242","","246"))
axis(side=1, las=0, lwd=1, cex.axis=.9, tck=-.05, at=c(1170306000,1170392400,1170478740), labels=c("Thu","Fri","Sat"))


# bottomleft plot
plot(subPower$DateTime, subPower$Sub_metering_1, xlab="", ylab="Energy sub metering", cex.lab=1, cex = .03, col="black", axes=F)
lines(subPower$DateTime, subPower$Sub_metering_1)
lines(subPower$DateTime, subPower$Sub_metering_2, col="red")
lines(subPower$DateTime, subPower$Sub_metering_3, col="blue")

legend( "topright",
        legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
        col=c("black","red","blue"),  lty=c(1,1), cex=.9, bty="n")

box()
axis(side=2, las=0, lwd=1, cex.axis=.9, tck=-.05)
axis(side=1, las=0, lwd=1, cex.axis=.9, tck=-.05, at=c(1170306000,1170392400,1170478740), labels=c("Thu","Fri","Sat"))


#bottomright plot
plot(subPower$DateTime, subPower$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", cex.lab=1, cex = .03, axes=F)
lines(subPower$DateTime, subPower$Global_reactive_power)
box()
axis(side=2, las=0, lwd=1, cex.axis=.9, tck=-.05)
axis(side=1, las=0, lwd=1, cex.axis=.9, tck=-.05, at=c(1170306000,1170392400,1170478740), labels=c("Thu","Fri","Sat"))

dev.off()

##