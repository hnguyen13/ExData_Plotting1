
#create a histogram of the Global Active Power column
plot1 <- function() {
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
#make the graph
mygraph <- hist(as.numeric(c2$Global_active_power), col="red",main= "Global Active Power", xlab="Global Active Power(kilowatts)", ylab="Frequency")
#export to png
dev.copy(png, file="plot1.png", width = 480, height = 480)

dev.off()
return(mygraph)
}
