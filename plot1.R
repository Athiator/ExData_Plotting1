
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

## Generate plot 1
png(file = "./plot1.png", width = 480, height = 480)
hist(powerData$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)",main = "Global Active Power")
dev.off()
