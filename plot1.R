library(lubridate)
library(dplyr)
library(tidyr)


#Read file

data<-read.table("../household_power_consumption.txt",header=TRUE,sep=";")
data$Date<-as.Date(data$Date, format = "%d/%m/%Y")
data_february<-data[year(data$Date)==2007 & month(data$Date)==02 & (day(data$Date)==01 | day(data$Date)==02),]
data_february[data_february$Global_active_power=="?",]<-NA
#Saving file

png(file="plot1.png",
    width=480, height=480)
hist(as.numeric(data_february$Global_active_power),main="Global Active Power",xlab="Global Active Power (kilowatts)",ylab="Frequency",col="red")
dev.off()