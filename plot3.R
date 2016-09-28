#Load library
library(data.table)
library(dplyr)

# Check "Data" directory is created and download zip file from web
if(!file.exists("./Data")) dir.create("./Data") 
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "./Data/dataset.zip")

# unzip file and remove the zip file
unzip("./Data/dataset.zip", exdir = "./Data")
file.remove("./Data/dataset.zip")

# read data into R and subset by date - 1&2/2/2007
y <- fread("./Data/household_power_consumption.txt", na.strings="?",stringsAsFactors = FALSE)   
sub.data <- full.data[full.data$Date %in% c("1/2/2007","2/2/2007"),]

#convert the Date and Time variables to Date/Time classes
sub.data$DateTime <- as.POSIXct(paste(sub.data$Date, sub.data$Time), format="%d/%m/%Y %H:%M:%S")

#Plot date/time vs all 3 submettering
png(file="plot3.png", width=480, height=480, units='px')
plot(sub.data$DateTime, as.numeric(sub.data$Sub_metering_1), type="l", xlab= "DateTime", ylab="Energy sub metering")
lines(sub.data$DateTime, as.numeric(sub.data$Sub_metering_2), col="red")
lines(sub.data$DateTime, as.numeric(sub.data$Sub_metering_3), col="blue")
legend("topright", lty=1, lwd=2.5, col=c("black", "red", "blue"), legend=c("Sub-metering 1", "Sub-metering 2", "Sub-metering 3"))
dev.off()  

