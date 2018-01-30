library("lubridate")
library("ggplot2")
dates <- read.csv("iv-changes.csv")
dates$Day <- as.Date(dates$Day,format="%m/%d/%Y")

