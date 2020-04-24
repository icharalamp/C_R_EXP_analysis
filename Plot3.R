# Load Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Load library
library(ggplot2)

# Subset NEI data by Baltimore's fip.
baltdata <- NEI[NEI$fips == "24510", ]

# Aggregate using sum the Baltimore emissions data by year
aggTotalsBaltimore <- aggregate(Emissions ~ year, baltdata, sum)


# Open png device
png(
  "plot3.png",
  width = 500,
  height = 500,
  units = "px",
  bg = "transparent"
)


# Plot grapgh
plot1 <- ggplot(baltdata, aes(factor(year), Emissions, fill = type)) +
  geom_bar(stat = "identity") +
  theme_bw() + guides(fill = FALSE) +
  facet_grid(. ~ type, scales = "free", space = "free") +
  labs(x = "year", y = expression("Total PM"[2.5] * " Emission (Tons)")) +
  labs(title = expression("PM"[2.5] * " Emissions, Baltimore City 1999-2008 by Source Type"))

print(plot1)

# Close device
dev.off()
