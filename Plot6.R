# Load Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Load library
library(ggplot2)

# Gather the subset of the NEI data which corresponds to vehicles
vh <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
vh_SCC <- SCC[vh, ]$SCC
vh_NEI <- NEI[NEI$SCC %in% vh_SCC, ]

# Subset the vehicles NEI data by each city's fip and add city name.
vh_BAL_NEI <- vh_NEI[vh_NEI$fips == "24510", ]
vh_BAL_NEI$city <- "Baltimore City"

vh_LA_NEI <- vh_NEI[vh_NEI$fips == "06037", ]
vh_LA_NEI$city <- "Los Angeles County"

# Combine the two subsets with city name into one data frame
bothNEI <- rbind(vh_BAL_NEI,vh_LA_NEI)


# Open png device

png("plot6.png",width=500,height=500,units="px",bg="transparent")


# Plot the graph
plot1 <- ggplot(bothNEI, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) + theme_bw() +
  labs(x="year", y=expression("Total PM"[2.5]*"Emission (KTons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

print(plot1)


#Close png device
dev.off()