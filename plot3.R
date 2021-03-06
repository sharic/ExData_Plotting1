# Shari Cartun
# plot3.R

# load Electric Power Consumption data into R
power <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)

# convert Date and numeric fields to applicable datatypes
power <- suppressWarnings(transform(power, Date=as.Date(power$Date, "%d/%m/%Y"), 
                                    Global_active_power=as.numeric(power$Global_active_power),
                                    Global_reactive_power=as.numeric(power$Global_reactive_power),
                                    Voltage=as.numeric(power$Voltage),
                                    Global_intensity=as.numeric(power$Global_intensity),
                                    Sub_metering_1=as.numeric(power$Sub_metering_1),
                                    Sub_metering_2=as.numeric(power$Sub_metering_2)))

# subset the data for 2/1/2007 and 2/2/2007
subPower <- power[(power$Date == '2007-02-01') | ((power$Date == '2007-02-02')),]

# concatenate the Date and Time variables into 1 column variable of type POSIXlt
subPower$DateTime <- strptime(paste(subPower$Date,subPower$Time, sep=" "), format="%Y-%m-%d %H:%M:%S")

### Create PLOT 3
png(file="plot3.png",width=480,height=480)
par(mfrow = c(1,1))

plot(subPower$DateTime, subPower$Sub_metering_1, xlab="", ylab="Energy sub metering",  cex = .03, col="black")
lines(subPower$DateTime, subPower$Sub_metering_1)
lines(subPower$DateTime, subPower$Sub_metering_2, col="red")
lines(subPower$DateTime, subPower$Sub_metering_3, col="blue")

legend( x= "topright", 
        legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
        col=c("black","red","blue"), lwd=1, lty=c(1,1), cex=1)
        
dev.off()

##