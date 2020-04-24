# Load Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset NEI data by Baltimore's fip.
balt <- NEI[NEI$fips == "24510", ]

# Aggregate using sum the Baltimore emissions data by year
aggTotalsBaltimore <- aggregate(Emissions ~ year, balt, sum)

# Open the png device
png(
  "plot2.png",
  width = 500,
  height = 500,
  units = "px",
  bg = "transparent"
)

# Plot the barplot
barplot(
  aggTotalsBaltimore$Emissions,
  names.arg = aggTotalsBaltimore$year,
  xlab = "Year",
  ylab = "PM2.5 Emissions (Tons)",
  main = "Total PM2.5 Emissions From all Baltimore City Sources"
)

#Close the png device
dev.off()