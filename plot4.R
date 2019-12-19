## Plot 4 for Exploratory Data Analysis Course Project

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
## Across the United States, how have emissions from coal combustion-related sources 
## changed from 1999–2008?

## Merge Data to add emisssion type names where SCC values are
if(!exists("merged_table")){
merged_table <- merge(NEI, SCC, by="SCC")
}

coal <- grepl("coal", merged_table$Short.Name, ignore.case = TRUE)
subset_NEISCC <- merged_table[coal,]

total_by_year <- aggregate(Emissions ~ year, subset_NEISCC, sum)

png("plot4.png")
g <- ggplot(data = total_by_year, mapping = aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") + xlab("year") + ylab("Total PM2.5 Emissions") + 
  ggtitle("Total Emissions from coal sources between 1999 and 2008")
print(g)
dev.off()
