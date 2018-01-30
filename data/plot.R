library("lubridate")
library("ggplot2")
library("ggthemes")
dates <- read.csv("iv-changes.csv")
dates$Day <- as.Date(dates$Day,format="%m/%d/%Y")
dates$Milestone <- as.character(dates$Milestone)
ggplot(dates,aes(x=Day,y=Changes,group=Class,color=Milestone,shape=Class))+geom_point(position='jitter',size=4) + scale_color_brewer(palette="Set1")
dates.hito2 <- dates[dates$Milestone == "2",]
ggplot(dates.hito2,aes(x=Day,y=Changes,group=Class,color=Class))+geom_line()
dates.hito3 <- dates[dates$Milestone == "3",]
ggplot(dates.hito3,aes(x=Day,y=Changes,group=Class,color=Class))+geom_line()
dates.hito4 <- dates[dates$Milestone == "4",]
ggplot(dates.hito4,aes(x=Day,y=Changes,group=Class,color=Class))+geom_line()
dates.hito5 <- dates[dates$Milestone == "5",]
ggplot(dates.hito5,aes(x=Day,y=Changes,group=Class,color=Class))+geom_line()
