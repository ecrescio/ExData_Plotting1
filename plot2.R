library(lubridate)
library(dplyr)
library(tidyr)


#Read file

data<-read.table("../household_power_consumption.txt",header=TRUE,sep=";")
data$Date<-as.Date(data$Date, format = "%d/%m/%Y")
data_february<-data[year(data$Date)==2007 & month(data$Date)==02 & (day(data$Date)==01 | day(data$Date)==02),]
data_february[data_february$Global_active_power=="?",]<-NA
data_february[data_february$Time=="?",]<-NA
data_february$Time<-strptime(data_february$Time,format="%H:%M:%S")

data_february$Datetime<-make_datetime(year(data_february$Date), month(data_february$Date), day(data_february$Date), hour(data_february$Time), minute(data_february$Time))

#Saving file

png(file="plot2.png",width=480, height=480)
plot(data_february$Datetime,data_february$Global_active_power,xlab="",ylab="Global Active Power (kilowatts)",type="n")
lines(data_february$Datetime,data_february$Global_active_power,xlab="",ylab="Global Active Power (kilowatts)")
dev.off()