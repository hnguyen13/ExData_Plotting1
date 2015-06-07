
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

# we need to graph two columns:  formatDT and sub metering.  We have 3 columns for sub_metering.
# Therefore, we need to combine them all into one column.  We will add a column to label which is which.
  
c3_1 <- subset(c2, select=c(formatDT, Sub_metering_1))
c3_2 <- subset(c2, select=c(formatDT, Sub_metering_2))
c3_3 <- subset(c2, select=c(formatDT, Sub_metering_3))

#rename the 2nd column to be "metering"
names(c3_1)[2] <- "metering"
names(c3_2)[2] <- "metering"
names(c3_3)[2] <- "metering"

#convert the metering values to numbers
c3_1$metering <- as.numeric(c3_1$metering)
c3_2$metering <- as.numeric(c3_2$metering)
c3_1$metering <- as.numeric(c3_1$metering)

#add a column category so we know which is from Sub_metering_1, Sub_metering_2 and so on.
c3_1$category <- "Sub_metering_1"
c3_2$category <- "Sub_metering_2"
c3_3$category <- "Sub_metering_3"

#add another column for color
c3_1$meteringColor <- "black"
c3_2$meteringColor <- "red"
c3_3$meteringColor <- "blue"

#merge the 3 little subsets into one large data set c3.
# first, clear it if it exists
if (exists("c3"))
{
   rm(c3)
}

c3 <- data.frame()
c3 <- rbind(c3, c3_1)
c3 <- rbind(c3, c3_2)
c3 <- rbind(c3, c3_3)

require(ggplot2)
library(ggplot2)
# This produces the days of the week in the x-axis but no colors
# mygraph <- with(c3, plot(formatDT, metering, main= "Energy Sub Metering on date 2007-02-01 and 2007-02-02", ylab="Energy sub metering", xlab="", type="l", col=c("black", "red", "blue")))
#mygraph <- qplot(formatDT, metering, data = c3, geom = "line", color = category) 

mygraph <- ggplot(data=c3, aes(x=formatDT, y=metering)) + geom_line(aes(color=factor(category))) + scale_colour_manual(values=c("black", "red", "blue"))  + labs(x = "", y = "Energy sub metering")  + theme(legend.title=element_blank(), legend.position=c(1,1),legend.justification = c(1, 1))
print(mygraph)

dev.copy(png, file="plot3.png", width = 480, height = 480)
dev.off()
return("Done plotting plot3.png")
}
