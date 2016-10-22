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
data <- read.table("./household_power_consumption.txt",header = TRUE,sep = ";")
data$Time <- strptime(data$Time, format = "%H:%M:%S")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
        for ( i in 3:9){
                data[,i]<-as.numeric(data[,i])
        }
data.sub <- subset(data,data$Date == "2007-02-02"| data$Date =="2007-02-01")

hist(data.sub$Global_active_power,col = "red",main = "Global Active Power",xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "Plot1.png")
dev.off()