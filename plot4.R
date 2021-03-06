## code for plot4
rm(list = ls())

##install.packages("sqldf")
library(sqldf)
setwd("~/Class/Exploratory Data Analysis/ProgramAssign1")

##Dataset: Electric power consumption [20Mb]
##Contains measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years
##Different electrical quantities and some sub-metering values are available.

##Descriptions of the 9 variables in the dataset are taken from the UCI web site:
##  Date: Date in format dd/mm/yyyy
##  Time: time in format hh:mm:ss
##  Global_active_power: household global minute-averaged active power (in kilowatt)
##  Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
##  Voltage: minute-averaged voltage (in volt)
##  Global_intensity: household global minute-averaged current intensity (in ampere)
##  Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
##  Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
##  Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.Loading the data
##  The dataset has 2,075,259 rows and 9 columns.

##Read data from the dates 2007-02-01 and 2007-02-02 (YYYY-MM-DD)
  fname <- "household_power_consumption.txt"
  
  datafl <- read.csv.sql("household_power_consumption.txt",
                         sql = "select Date||Time as DateTime, Global_active_power, Global_reactive_power,
                                       Voltage, Global_intensity, Sub_metering_1, Sub_metering_2, Sub_metering_3       
                                  from file WHERE Date in ('1/2/2007', '2/2/2007')",
                         header = TRUE, sep = ";")
##Convert the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions.
  datafl$DateTime <- strptime(datafl$DateTime, "%d/%m/%Y%H:%M:%S")
## Modify missing values in dataset from ? to NA
  ##datafl$Sub_metering_2[datafl$Sub_metering_2 == "?"] <- NA
  
## Plot4
  pdf(file="plot4.pdf")
  par(mfrow = c(2, 2))
  
  ## Top left plot
  plot(datafl$DateTime, datafl$Global_active_power, type="n", col='black',
       xlab="", ylab="Global Active Power")
  lines(datafl$DateTime, datafl$Global_active_power)
  
  ## Top right plot
  plot(datafl$DateTime, datafl$Voltage, type="n", col='black',
       xlab="datetime", ylab="Voltage")
  lines(datafl$DateTime, datafl$Voltage)
  
  ## Bottom left plot
  plot(datafl$DateTime, datafl$Sub_metering_1, type="n",
       xlab="", ylab="Energy sub metering")
  lines(datafl$DateTime, datafl$Sub_metering_1, col='black')
  
  points(datafl$DateTime, datafl$Sub_metering_2, type="n")
  lines(datafl$DateTime, datafl$Sub_metering_2, col='red')
  
  points(datafl$DateTime, datafl$Sub_metering_3, type="n")
  lines(datafl$DateTime, datafl$Sub_metering_3, col='blue')
  
  legend("topright", lwd = 2, bty = "n", col=c("black","red", "blue"),
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  ## Bottom right plot
  plot(datafl$DateTime, datafl$Global_reactive_power, type="n", col='black',
       xlab="datetime", ylab="Global_reactive_power")
  lines(datafl$DateTime, datafl$Global_reactive_power)
  
  dev.off()

  
     

