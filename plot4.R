
## Read in the data. This method inspired by a post on the class forums by Cory Brunson

## Identify the lines for the correct dates
lines <-grep('^[1-2]/2/2007',readLines('./household_power_consumption.txt'))
skipRows <- lines[1] - 1

powerData <- read.table("./household_power_consumption.txt", sep = ";", skip = skipRows, na.strings = "?", nrows = length(lines))

## That data frame doesn't pick up the header, so, read the first couple of lines and copy the column names across:

powerHeader <- read.table("./household_power_consumption.txt", sep = ";",header = TRUE, nrows = 1)

colnames(powerData)<-colnames(powerHeader)

## Set the date and time columns to be objects of those classes.
## powerData$Date <- as.Date(powerData$Date, format = "%d/%m/%Y")

powerData <- transform(powerData, TrueTime = strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

## Generate plot 4
png(file = "./plot4.png", width = 480, height = 480)
par(mfrow = c( 2, 2))
plot(powerData$TrueTime, powerData$Global_active_power, type = 'l', xlab = "", ylab = "Global Active Power", main = "")

plot(powerData$TrueTime, powerData$Voltage, type = 'l', xlab = "datetime", ylab = "Voltage", main = "", yaxt = "n")
axis(2, at = c(234, 236, 238, 240, 242, 244, 246), labels = c("234","", "238", "", "242", "", "246"))

plot(powerData$TrueTime, powerData$Sub_metering_1, type = 'l', xlab = "", ylab = "Energy sub metering", main = "")
lines(powerData$TrueTime, powerData$Sub_metering_2, col = "red")
lines(powerData$TrueTime, powerData$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1, bty = "n")
plot(powerData$TrueTime, powerData$Global_reactive_power, type = 'l', xlab = "datetime", ylab = "Global_reactive_power", main = "")

dev.off()
