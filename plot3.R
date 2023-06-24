library(dplyr)

rm(list = ls())

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dest_path <- '../dataset.zip'

# download dataset (zip file)
if (!file.exists(dest_path)){
  download.file(url,dest_path)
}

ds_path <- '../household_power_consumption.txt'
# unzip file
if (!file.exists(ds_path)){
  unzip(dest_path)
}

#load dataset, Date == 1/2/2007 | 2/2/2007
col_names <- c("Date", "Time", "Global_active_power", "Global_reactive_power", 
               "Voltage", "Global_intensity", "Sub_metering_1","Sub_metering_2",
               "Sub_metering_3")
ds <- read.table(ds_path, header=FALSE, sep=";", skip=66637, nrows = 2880,col.names=col_names)

#convert the Date and Time variables to Date/Time classes
ds <- mutate(ds, DateTime = strptime(paste(Date, Time, sep=' '), '%d/%m/%Y %H:%M:%S'))
ds <- select(ds, -(Date:Time))

#plot and save png file
png(file="plot3.png", width=480, height=480)


with(ds, plot(Sub_metering_1, type="S", ylab='Energy sub metering',
              xlab='',xaxt = "n",lty=1))

with(ds, lines(Sub_metering_2, col='red',lty=1))

with(ds, lines(Sub_metering_3, type="S", col='blue',lty=1))

#legend(1, 95, legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
 #      col=c("black", "red", "blue"))

legend(x = "topright",
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       lty = c(1, 1, 1),
       col = c("black", "red", "blue"))


axis(1, at = c(0,1439,2879), labels = c('Tue', 'Fri', 'Sat'))


dev.off()

