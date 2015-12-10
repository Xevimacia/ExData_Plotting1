####### Plot 1 R code #######
setwd("~/Coursera") # Set working directory

### Read the text file
if(!file.exists("plot")) { dir.create("plot") } # if directory does not exist create it
# download the zip file
myurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(myurl, "~/Coursera/plot/household_power_consumption.zip", mode="wb")
# Unzip the zip file and read it to data frame called dat
# Read the data from just 2007-02-01 and 2007-02-02 dates with skip and nrows 
con <- unz("~/Coursera/plot/household_power_consumption.zip",
           "household_power_consumption.txt")
mytitles <- c("Date", "Time", "Global_active_power", "Global_reactive_power",
              "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
              "Sub_metering_3")
dat <- read.table(con, header=T, sep=";", nrows = 2880, skip = 66636, col.names = mytitles)
# Check that dataset has no missing values in dat
print(paste("Missing values =", sum(!complete.cases(dat)))) 

# Convert Date column to Date variable with as.Date()
dat$Date <- as.Date(as.character(dat$Date),format="%d/%m/%Y") # Convert to Date variable type
dat$Date <- as.Date(dat$Date,format="%Y-%m-%d") # Change to desired format

# Convert Time column to Time variable with strptime()
TempDateTime <- paste(as.character(dat$Date), as.character(dat$Time)) # Paste date and time in temp variable
dat$Time <- strptime(TempDateTime, "%Y-%m-%d %H:%M:%S") # use strptime to generate "POSIXlt" "POSIXt" variables 

# Plot 1 histogram dat$Global_active_power
par(mfrow = c(1, 1), mar = c(5, 5, 3, 2)) # set number of graphs and margins
hist(dat$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

## Copy plot 1 to a PNG file
dev.copy(png, file = "~/Coursera/plot/plot1.png", width=480,height=480)
# close the PNG device
dev.off()
