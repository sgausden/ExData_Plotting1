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

    for (i in 3:9)
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



#   Plot 1

png("Plot1.png")
hist(PD.sub$Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)", col="red")
dev.off()