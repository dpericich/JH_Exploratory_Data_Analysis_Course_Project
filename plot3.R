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

## Use Base Plot System to Answer:

## Of the four types of sources indicated by the \color{red}{\verb|type|}type 
## (point, nonpoint, onroad, nonroad) variable, which of these four sources have 
## seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen 
## increases in emissions from 1999–2008? Use the ggplot2 plotting system to make 
## a plot answer this question.

## Subset data to only include rows for Baltimore City (fips == "24510")
NEI_sub <- NEI[NEI$fips == "24510",]

aggregate_total_year_and_type <- aggregate(Emissions ~ year + type, NEI_sub, sum)

## Plot using ggplot
png('plot3.png')
g <- ggplot(data = aggregate_total_year_and_type, mapping = aes(year, Emissions, color = type))
g <- g + geom_line() +
    xlab("Year") +
    ylab("Total PM2.5 Emissions") +
    ggtitle("Total Emissions by Type for Baltimore City, MD from 1999 to 2008")
print(g)
dev.off()
