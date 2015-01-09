dtime <- difftime(as.POSIXct("2007-02-03"), as.POSIXct("2007-02-01"),units="mins")
rowsToRead <- as.numeric(dtime)
DT <- fread("household_power_consumption.txt",skip="1/2/2007", nrows = rowsToRead, na.strings = c("?", ""))
setnames(DT, colnames(fread("household_power_consumption.txt", nrows=0)))


DateTime <- as.POSIXct(paste(DT$Date,DT$Time),format="%d/%m/%Y %H:%M:%S")
data_full <- DT
data_full$DateTime <- DateTime
plot(x=data_full$DateTime, y=data_full$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")


dev.copy(png, file="plot2.png")
dev.off()

