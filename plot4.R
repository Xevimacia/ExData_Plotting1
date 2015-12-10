####### Plot 4 R code #######
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

# Parameters of the plot
par(mfrow = c(2, 2), mar = c(5, 5, 3, 2)) # set number of graphs and margins

# Plot graphs
with (dat,{
        
        # Plot graph 1 with x-axis dat$Time and y-axis dat$Global_active_power
        plot(Time, Global_active_power,  type = "l", xlab = "",
             ylab = "Global Active Power", lty = 1)

        # plot graph 2 with x-axis dat$Time and y-axis dat$Voltage
        plot(Time, Voltage,  type = "l", xlab = "datetime",
             ylab = "Voltage", lty = 1)
        
        # plot graph 3
        # type ="n" sets up the plot and does not fill it with data
        plot(Time, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
        lines(Time, Sub_metering_1, col = "black") # Plot Sub_metering_1 in black color
        lines(Time, Sub_metering_2,  col = "red") # Plot Sub_metering_2 in red color
        lines(Time, Sub_metering_3,  col = "blue") # Plot Sub_metering_3 in blue color
        # plot the legend of the components of the graph
        legend("topright", inset=c(0.22,0), lty = 1, col = c("black", "red", "blue"),
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n", cex = 0.7)

        # plot graph 4 with x-axis dat$Time and y-axis dat$Global_reactive_power
        plot(Time, Global_reactive_power,  type = "l", xlab = "datetime", lty = 1)
}
)
## Copy plot 4 to a PNG file
dev.copy(png, file = "~/Coursera/plot/plot4.png", width=480,height=480)
# close the PNG device
dev.off()