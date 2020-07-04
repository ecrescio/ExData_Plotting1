#Read file

data<-read.table("../household_power_consumption.txt",header=TRUE,sep=";")
data$Date<-as.Date(data$Date, format = "%d/%m/%Y")
data_february<-data[year(data$Date)==2007 & month(data$Date)==02 & (day(data$Date)==01 | day(data$Date)==02),]
data_february$Time<-strptime(data_february$Time,format="%H:%M:%S")

data_february$Datetime<-make_datetime(year(data_february$Date), month(data_february$Date), day(data_february$Date), hour(data_february$Time), minute(data_february$Time))

data_february$Sub_metering_2 <- as.numeric(data_february$Sub_metering_2)
good2 <- data_february$Sub_metering_2 < 12
data_february$Sub_metering_2[!good2]<-0


png(file="plot4.png",width=480, height=480)
par(mfrow=c(2,2))
with(data_february,{
  plot(data_february$Datetime,data_february$Global_active_power,xlab="",ylab="Global Active Power (kilowatts)",type="n")
  lines(data_february$Datetime,data_february$Global_active_power,xlab="",ylab="Global Active Power (kilowatts)")
  plot(data_february$Datetime,data_february$Voltage,xlab="datetime",ylab="Voltage",type="n")
  lines(data_february$Datetime,data_february$Voltage,xlab="datetime",ylab="Voltage")
    plot(data_february$Datetime,data_february$Sub_metering_1,ylab="Energy sub metering",xlab="",type="n")
  lines(data_february$Datetime,data_february$Sub_metering_1,col="black")
  lines(data_february$Datetime,data_february$Sub_metering_2,col="red")
  lines(data_february$Datetime,data_february$Sub_metering_3,col="blue")
  legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  plot(data_february$Datetime,data_february$Global_active_power,ylab="Global Active Power",xlab="datetime",type="n")
  lines(data_february$Datetime,data_february$Global_active_power,col="black")
  
})
dev.off()