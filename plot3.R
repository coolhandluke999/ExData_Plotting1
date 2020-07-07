library(lubridate)

#Download, unzip, and load Dataset

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("./data")){
        dir.create("./data")
}

if(!file.exists("./data/electricpowerconsumption.zip")) {
        download.file(url,destfile="./data/electricpowerconsumption.zip",method="curl")
}

unzip("./data/electricpowerconsumption.zip", exdir = "./data")

data <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?",
                        colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))


#Format Data and Time columns
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
#Subset dataset and combine data and time fields
dataset <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]
dataset$datetime <- with(dataset, as.POSIXct(paste(Date, Time)))
#Open PNG device and set dimensions
png(filename = "plot4.png", width = 480, height = 480)
#Plot 4

yticks <- seq(0, 30, 10)
plot(dataset$datetime, dataset$Sub_metering_1, col = "black", type = "n", main = "", xlab = "", yaxt = "n", ylab = "Energy sub metering")
axis(side = 2, at = yticks, labels = c("0", "10", "20", "30"), lwd = 2 )
lines(dataset$datetime, dataset$Sub_metering_1, col = "black")
lines(dataset$datetime, dataset$Sub_metering_2, col = "red")
lines(dataset$datetime, dataset$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), lwd = "1", seg.len = 1, xjust = 1,legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Save plot as .png
dev.off()


