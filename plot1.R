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

#Plot 1
attach(selected)
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency", col = "red")
dev.off()






