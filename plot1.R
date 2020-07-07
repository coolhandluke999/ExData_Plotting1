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
data$Time <- strptime(data$Time, format = "%H:%M:%S")

dataset <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]

#Open PNG device and set dimensions
png(filename = "plot3.png", width = 480, height = 480)

#Plot 1

plot1 <- hist(dataset$Global_active_power, col = "firebrick1", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

#Save plot as .png

dev.off()