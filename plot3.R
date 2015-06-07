
plot3 <- function() {
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

mygraph <- with(c2, plot(formatDT, Sub_metering_1, type = "n", ylab="Energy sub metering", xlab=""))
    with(c2, lines(formatDT, Sub_metering_1, col = "black"))
    with(c2, lines(formatDT, Sub_metering_2, col = "red"))
    with(c2, lines(formatDT, Sub_metering_3, col = "blue"))#mygraph <- qplot(formatDT, metering, data = c3, geom = "line", color = category) 

dev.copy(png, file="plot3.png", width = 480, height = 480)
dev.off()
return("Done plotting plot3.png")
}
