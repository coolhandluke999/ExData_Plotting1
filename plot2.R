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
png(filename = "plot2.png", width = 480, height = 480)

#Plot 2

plot(dataset$datetime, dataset$Global_active_power, type = "l", main = "", xlab = "", ylab = "Global Active Power (kilowatts)")
axis(2, lwd = "3")


#Save plot as .png

dev.off()

?axis()
