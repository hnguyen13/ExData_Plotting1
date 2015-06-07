# create a line graph of the Global_active_power for each day.
plot2 <- function() {
#read in the table
con1 <- read.table("exdata-data-household_power_consumption/household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors=FALSE, na.strings="NA")
#format the date
con1$formatDate <- as.Date(con1$Date, "%d/%m/%Y")
#create a subset for just the 2 specified dates
c2 <- subset(con1, formatDate == "2007-02-01" | formatDate == "2007-02-02")
#combine the Date and Time column in the DateTime column
c2$DateTime <- paste(c2$Date, c2$Time)
#format the combined dateTime
c2$formatDT <- as.POSIXct(strptime(c2$DateTime, "%d/%m/%Y %H:%M:%S"))
# make the graph
mygraph <- with(c2, plot(formatDT, Global_active_power, main= "Consumption on date 2007-02-01 and 2007-02-02", ylab="Global Active Power(kilowatts)", xlab="", type="l"))
#export to png
dev.copy(png, file="plot2.png", width = 480, height = 480)
dev.off()
return("Done")
}
