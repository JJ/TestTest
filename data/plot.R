library("lubridate")
library("ggplot2")
dates <- read.csv("iv-changes.csv")
dates$Day <- as.Date(dates$Day,format="%m/%d/%Y")
 ggplot(dates,aes(x=Day,y=Changes,group=Class,color=Milestone))+geom_point()

