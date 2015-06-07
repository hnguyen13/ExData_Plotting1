
plot4 <- function() {
#read in the table
c1 <- read.table("exdata-data-household_power_consumption/household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors=FALSE, na.strings="NA")
#format the date
c1$formatDate <- as.Date(c1$Date, "%d/%m/%Y")
#create a subset for just the 2 specified dates
c2 <- subset(c1, formatDate == "2007-02-01" | formatDate == "2007-02-02")
#combine the Date and Time column in the DateTime column
c2$DateTime <- paste(c2$Date, c2$Time)
#format the combined dateTime
c2$formatDT <- as.POSIXct(strptime(c2$DateTime, "%d/%m/%Y %H:%M:%S"))
#convert the Sub_metering values to numeric
c2$Sub_metering_1 <- as.numeric(c2$Sub_metering_1)
c2$Sub_metering_2 <- as.numeric(c2$Sub_metering_2)
c2$Sub_metering_3 <- as.numeric(c2$Sub_metering_3)


#plotting
png(file="plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
mygraph1 <- with(c2, plot(formatDT, Global_active_power, ylab="Global Active Power", xlab="", type="l"))
mygraph2 <- with(c2, plot(formatDT, Voltage, ylab="Voltage", xlab="", type="l"))
mygraph3 <- with(c2, plot(formatDT, Sub_metering_1, type = "n", ylab="Energy sub metering", xlab=""))
    with(c2, lines(formatDT, Sub_metering_1, col = "black"))
    with(c2, lines(formatDT, Sub_metering_2, col = "red"))
    with(c2, lines(formatDT, Sub_metering_3, col = "blue"))
mygraph4 <- with(c2, plot(formatDT, Global_reactive_power, ylab="Global Reactive Power(kilowatts)", xlab="", type="l"))

dev.off()
return("Done plotting plot4.png")
}
