#   Load Packages
install.packages("lubridate")
library("lubridate")


# Get Working Directory

setwd("./R/Coursera Data Science/Exploratory Data Analysis")
destfile<-file.path(getwd(),"PowerData.zip")


#   Load Data

sourcedata<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(sourcedata,destfile)
unzip("PowerData.zip")

PowerData<-read.table("household_power_consumption.txt", TRUE,";")

#   Change colClasses

PowerData$Date<-dmy(PowerData$Date)
PowerData$Time<-hms(PowerData$Time)

xfor (i in 3:9)
{  
    PowerData[,i]<-as.numeric(as.character(PowerData[,i]))
}

#   Subset Data

startdate<-ymd("2007-02-01")
enddate<-ymd("2007-02-02")

PD.sub<-PowerData[PowerData$Date<=enddate,]
PD.sub<-PD.sub[PD.sub$Date>=startdate,]

#   Create Date Time

PD.sub$date.time<-PD.sub$Date+PD.sub$Time






#   Plot 4

png("Plot4.png")

par(mfrow=c(2,2))

plot(y=PD.sub$Global_active_power,x=PD.sub$date.time,
     ylab="Global Active Power (kilowatts)",xlab='',type="l")
lines(PD.sub$Global_active_power,PD.sub$date.time)


plot(y= PD.sub$Voltage,x=PD.sub$date.time,
     ylab="Voltage",xlab='datetime',type="l")


plot(y=PD.sub$Sub_metering_1, x=PD.sub$date.time,
     ylab="Energy sub metering",xlab='',type="l")

lines(x=PD.sub$date.time,y=PD.sub$Sub_metering_2,col="red")
lines(x=PD.sub$date.time,y=PD.sub$Sub_metering_3,col="blue")

?legend
legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),bty=1,col=c("black", "red", "blue"), lwd=2)


plot(y= PD.sub$Global_reactive_power,x=PD.sub$date.time,
     ylab="Global_reactive_power",xlab='datetime',type="l")



dev.off()