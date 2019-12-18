## Plot 1 for Exploratory Data Analysis Course Project

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

## Use Base Plotting System to Answer:

## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from 
## all sources for each of the years 1999, 2002, 2005, and 2008.

emissions_by_year <- aggregate(Emissions ~ year, NEI, sum)

png('plot1.png')
barplot(height = emissions_by_year$Emissions, names.arg = emissions_by_year$year, 
        xlab = "year", ylab = "Total Emissions PM2.5 [tons]", main = "Total PM2.5 emissions
        for select years")
dev.off()