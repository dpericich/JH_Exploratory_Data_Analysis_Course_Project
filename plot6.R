## Plot 3 for Exploratory Data Analysis Course Project

## Load necessary library
library(ggplot2)

## Create file name for zip
filename <- "JH_project2.zip"

## Download file if not already in directory
if(!file.exists(filename)) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(fileURL, filename, method = "curl")
}

## Unzip file
unzip(filename)

## Read in both files from zipfile
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset for each city and combine to one data frame
subsetNEI <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]

aggByYearAndFips <- aggregate(Emissions ~ year + fips, subsetNEI, sum)
aggByYearAndFips$fips[aggByYearAndFips$fips=="24510"] <- "Baltimore, MD"
aggByYearAndFips$fips[aggByYearAndFips$fips=="06037"] <- "Los Angeles, CA"

png("plot6.png", width=1040, height=480)
g <- ggplot(aggByYearAndFips, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle in Baltimore City, MD vs Los Angeles, CA  1999-2008')
print(g)
dev.off()