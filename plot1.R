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

# Plot a histogram for Global active power
png(file="plot1.png")
hist(sub.data$Global_active_power, main="Global Active Power", col="red", xlab="Gloabl Active Power (kilowatts)")
dev.off()
