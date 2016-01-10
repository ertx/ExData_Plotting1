# Download the required zip file if it hasn't already been downloaded 
data_file <- file.path("household_power_consumption.zip")
if(!file.exists(data_file)){
URL <- "https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip" 
download.file(URL, destfile=data_file)
}

# Unzip the file and load files in the specific directory
unzip(data_file)

# Read, select, and transform data as required

file <- "household_power_consumption.txt"
df_powerconsumption <- read.table(file, colClasses=c(rep("character",2), rep("numeric",7)), sep = ";", na="?", header = TRUE)
df_powerconsumption$Date <- as.Date(df_powerconsumption$Date, format="%d/%m/%Y")
df_powerconsumption <- subset(df_powerconsumption, Date=="2007-02-01" | Date=="2007-02-02")
df_powerconsumption <- transform(df_powerconsumption, timestamp=as.POSIXct(paste(Date, Time)), "%Y/%m/%d %H:%M:%S")

# Delete files that are no longer required.
unlink(data_file)

# Plot
hist(df_powerconsumption$Global_active_power,xlab="Global Active Power (kilowatts)",ylab="Frequency",main="Global Active Power",col="red")
dev.off()

png("plot1.png", width = 480, height = 480, units = "px", bg = "white")
par(mar= c(4, 4, 2, 1))
hist(df_powerconsumption$Global_active_power,xlab="Global Active Power (kilowatts)",ylab="Frequency",main="Global Active Power",col="red")
