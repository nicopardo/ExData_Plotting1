#clean environment
rm(list = ls())

#libraries
library(lubridate)
library(tibble)
library(dplyr)

#download the data set
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "power_consumption.zip")
unzip("power_consumption.zip")
downloaded <- now()

#read the data set into r
power <- read.table("household_power_consumption.txt", sep =";", na.strings = "?", header = T)


#further formatting
power2 <- tbl_df(power)
power2$Date <- dmy(power2$Date)
selected <- filter(power2, Date>= "2007-02-01" & Date<= "2007-02-02")
rm(power, power2)

selected <- mutate(selected, full_date = ymd_hms(paste(as.character(Date), as.character(Time), sep = " ")))


#plot4

plot.new()

png(filename = "plot4.png", width = 480, height = 480, units = "px")

par(mfrow=c(2,2))

with(selected, plot(full_date, Global_active_power, type = "l", 
                    xlab = "", ylab = "Global Active Power (kilowatts)"))

with(selected, plot(full_date, Voltage, type = "l", 
                    xlab = "datetime", ylab = "Voltage"))

with(selected, plot(full_date, Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "" ))
with(selected, lines(full_date, Sub_metering_1, col = "black"))
with(selected, lines(full_date, Sub_metering_2, col = "red"))
with(selected, lines(full_date, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, bty = "n", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"))

with(selected, plot(full_date, Global_reactive_power, type = "l", lwd = 0.5,  
                    xlab = "datetime"))

dev.off()






