library("ggplot2")
library("ggthemes")
library("dplyr")
users <- read.csv("user-stats.csv")
users$Milestone <- as.character(users$Milestone)
ggplot(users,aes(x=Milestone,y=Changes,group=Class,color=Class))+geom_point(position='jitter',size=4) + scale_color_brewer(palette="Set1")
ggplot(users,aes(x=Milestone,y=Changes,color=Class))+geom_boxplot(notch=TRUE)+scale_y_log10()+theme_tufte()

user.stats <- users %>% group_by(Class, Milestone, Changes) %>% tally()
ggplot(user.stats,aes(x=Changes,y=n,color=Milestone,shape=Class))+geom_point(position='jitter',size=4) + scale_color_brewer(palette="Set1") 


user.milestone <- users %>% group_by(Class, Milestone) %>% tally()
ggplot(user.milestone,aes(x=Milestone,y=n,group=Class,color=Class,size=n))+geom_line()+theme_tufte()

print(summary(users[users$Class==' IV-2015-16',]))
print(summary(users[users$Class==' IV16-17',]))
print(summary(users[users$Class==' IV-17-18',]))
