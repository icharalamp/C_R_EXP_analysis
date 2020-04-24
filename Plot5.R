# Load data 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Load library
library(ggplot2)

# Gather the subset of the NEI data which corresponds to vehicles
vh <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
vhSCC <- SCC[vh, ]$SCC
vhNEI <- NEI[NEI$SCC %in% vhSCC, ]

# Subset the vehicles NEI data to Baltimore's fip
balt_vh_NEI <- vhNEI[vhNEI$fips=="24510",]


# Open png device
png("plot5.png",width=500,height=500,units="px",bg="transparent")


# Plot the graph
grapgh <- ggplot(balt_vh_NEI,aes(factor(year),Emissions)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

print(grapgh)

dev.off()