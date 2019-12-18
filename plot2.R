## Plot 2 for Exploratory Data Analysis Course Project

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

## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
## (\color{red}{\verb|fips == "24510"|}fips=="24510") from 1999 to 2008? Use 
## the base plotting system to make a plot answering this question.

NEI_sub <- NEI[NEI$fips == "24510",]

emissions_by_year <- aggregate(Emissions ~ year, NEI_sub, sum)

png('plot2.png')
barplot(height = emissions_by_year$Emissions, names.arg = emissions_by_year$year, 
        xlab = "year", ylab = "Total Emissions PM2.5 [tons]", main = "Total PM2.5 emissions
        for select years for Baltimore City, MD")
dev.off()