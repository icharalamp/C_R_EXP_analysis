# Load Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Load the library
library(ggplot2)

# Subset coal combustion related NEI data
comp_rela <-  grepl("comb", SCC$SCC.Level.One, ignore.case = TRUE)
col_rel <- grepl("coal", SCC$SCC.Level.Four, ignore.case = TRUE)
col_comp <- (comp_rela & col_rel)
combustionSCC <- SCC[col_comp, ]$SCC
comp_nei <- NEI[NEI$SCC %in% combustionSCC, ]


# Open png device
png("plot4.png",width=500,height=500,units="px",bg="transparent")



#Plot the graph
ggp <- ggplot(comp_nei,aes(factor(year),Emissions/10^5)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))

print(ggp)

# Close device
dev.off()
