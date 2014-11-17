library(ggplot2)
library(reshape2)
library(animation)
data <- read.table("Deaths_1x1.txt",sep = "",nrows=8660,header=TRUE)
datp <- data[-which(data$Age=="110+"),]
birth <- datp$Year-as.integer(as.character(datp$Age))
df <- data.frame(age=as.integer(as.character(datp$Age)),b=birth,female=datp$Female,male=datp$Male)
dfp<-melt(df,id=c("age","b"))

for(i in 1910:2000) {
print(qplot(dfp$age[which(dfp$b==i)],dfp$value[which(dfp$b==i)],color=dfp$variable[which(dfp$b==i)],xlab="Age",ylab="Deaths",xlim=c(0,110),ylim=c(0,70000)) + ggtitle(paste("Born in ",as.character(i))) + scale_colour_discrete(name = "Gender"))
ani.record()
}

ani.options(interval=0.3)
saveGIF(ani.replay(),movie.name="mortality.gif")
