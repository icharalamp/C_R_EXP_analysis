# Load Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Aggregate by sum the total emissions by year
aggTotals <- aggregate(Emissions ~ year, NEI, sum)


# Open the png device
png(
  "plot1.png",
  width = 500,
  height = 500,
  units = "px",
  bg = "transparent"
)

# BarPlot1
barplot(
  (aggTotals$Emissions)/10^6,
  names.arg=aggTotals$year,
  xlab="Year",
  ylab="PM2.5 Emissions (10^6 Tons)",
  main="Total PM2.5 Emissions From All US Sources"
)



# Close the device 
dev.off()
