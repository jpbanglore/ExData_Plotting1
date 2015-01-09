dtime <- difftime(as.POSIXct("2007-02-03"), as.POSIXct("2007-02-01"),units="mins")
rowsToRead <- as.numeric(dtime)
DT <- fread("household_power_consumption.txt",skip="1/2/2007", nrows = rowsToRead, na.strings = c("?", ""))
setnames(DT, colnames(fread("household_power_consumption.txt", nrows=0)))


DateTime <- as.POSIXct(paste(DT$Date,DT$Time),format="%d/%m/%Y %H:%M:%S")
data_full <- DT
data_full$DateTime <- DateTime

par(mfrow=c(2,2))

with(data_full,plot(x=data_full$DateTime, y=data_full$Global_active_power, type="l", ylab="Global Active Power", xlab=""))
with(data_full,plot(x=data_full$DateTime, y=data_full$Voltage, type="l", ylab="Voltage", xlab="datetime"))

with(data_full,plot(x=data_full$DateTime, y=data_full$Global_intensity, type="n", ylab="Energy sub metering", xlab=""))
with(data_full,lines(x=data_full$DateTime, y=data_full$Sub_metering_1, type="l",col="black"))
with(data_full,lines(x=data_full$DateTime, y=data_full$Sub_metering_2, type="l",col="red"))
with(data_full,lines(x=data_full$DateTime, y=data_full$Sub_metering_3, type="l",col="blue"))

legend_labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend_colors <- c("black", "red", "blue")
legend("topright", legend = legend_labels, col = legend_colors, lty = 1, bg = "transparent", cex = 0.2)

with(data_full,plot(x=data_full$DateTime, y=data_full$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime"))

dev.copy(png, file="plot4.png")
dev.off()
