filename <- "StormData.csv.bz2"
url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"

if (!file.exists(filename)) {
    download.file(url=url, destfile = filename, method="curl")
}
raw.data.full <- read.csv(
    filename, header=TRUE, na.strings=c(""))