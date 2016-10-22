## Exploratory data project


## Download and unzip the dataset:
filename <- "getdata_dataset.zip"
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename, mode = "wb")
}  
if (!file.exists("household_power_consumption.txt")) { 
  unzip(filename) 
}

#Load data,change column classes, and filter data
data <- read.csv("./household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                 nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

data$Date <- as.Date(data$Date, format="%d/%m/%Y")

data <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Plot 4
par(mfrow=c(2,2), mar = c(5, 4, 2, 1))
#1 of 4
plot(data$Global_active_power~data$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

#2 of 4
plot(data$Voltage~data$Datetime, type="l",
     ylab="Voltage", xlab="datetime")

#3 of 4
with(data, {
  plot(Sub_metering_1~Datetime, type="l",ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, cex = .75,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#4 of 4
plot(data$Global_reactive_power~data$Datetime, type="l",
     ylab="Global_reactive_power", xlab="datetime")


dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()