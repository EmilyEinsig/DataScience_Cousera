#Exploratory Data Analysis - Homework 1
#Plot 2

# Read in data from URL
temp <- tempfile()
setInternet2(use=TRUE)
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
dat <- read.table(unz(temp,"household_power_consumption.txt"),header=TRUE,sep=";", na.strings = "?")
unlink(temp)

# Only use data from 2007-02-01 and 2007-02-02
df <- dat[(dat$Date=="1/2/2007" | dat$Date == "2/2/2007"),] 

remove('dat')	#clear workspace

# Combine and Convert Date & Time columns to date & time variables
df$DateTime <- paste(df$Date,df$Time)

drops <- c("Date","Time")			# remove Date, Time columns
df <- df[,!(names(df) %in% drops)]

df$DateTime <- strptime(df$DateTime,"%d/%m/%Y %H:%M:%S")

# Create Plots

# Plot 2
png(file = "plot2.png",width = 480, height = 480)
plot(df$DateTime,df$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")


dev.off()