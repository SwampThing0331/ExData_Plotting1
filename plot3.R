#getwd()
#setwd('~/datasciencecoursera/ExData_Plotting1')

library(sqldf)
library(data.table)
library(tidyverse)

data_url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

if(!file.exists("./exdata%2Fdata%2Fhousehold_power_consumption.zip")) {
      download.file(data_url, "exdata%2Fdata%2Fhousehold_power_consumption.zip")
}
if(!file.exists("./household_power_consumption.txt")) {
      unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip")
}

epc_data <- read.csv.sql("./household_power_consumption.txt"
                        ,sql = "select * from file where Date in('1/2/2007', '2/2/2007')"  
                        ,sep = ";", eol = "\n", header = TRUE, stringsAsFactors = FALSE)

epc_data[epc_data == "?"] <- NA
epc_data$Date <- as.Date(epc_data$Date, format = "%d/%m/%Y")
epc_data$DT <- paste(epc_data$Date, epc_data$Time, sep = " ")
epc_data$DT <- strptime(epc_data$DT, format = "%Y-%m-%d %H:%M:%S", tz = "")

png(filename = "./plot3.png", width = 480, height = 480, units = "px")
plot(x = epc_data$DT, y = epc_data$Sub_metering_1, type = "l"
      ,xlab = "", ylab = "Energy sub metering")
lines(x = epc_data$DT, y = epc_data$Sub_metering_2, col = "red")
lines(x = epc_data$DT, y = epc_data$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), lty = 1
       ,legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()