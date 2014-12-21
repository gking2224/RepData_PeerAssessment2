
health <- merge(byinjuries, byfatalities)
health <- health[order(health$fatalities, health$injuries, decreasing = TRUE),]
health <- health[1:10,]
dimnames(health$fatalities) <- NULL
dimnames(health$injuries) <- NULL
health$evtype <- factor(health$evtype)

library(reshape2)
hm <- melt(health, measure.vars=c("fatalities", "injuries"),
           id.vars="evtype", variable.name="type", value.name="count")
dim(hm$count) <- NULL

library(ggplot2)
gp <- ggplot(hm, aes(x=evtype, y=count))
gp <- gp + geom_bar(stat="identity")
gp <- gp + facet_grid(type ~ ., scales="free_y", labeller=function(x,y){ifelse(y=="fatalities","Fatalities", "Injuries")})
gp <- gp + xlab("Weather Event Type") + ylab("Incidence (total in the period)")
gp <- gp + ggtitle("Figure 2: Health impact of US weather events (1995-2011)")
gp <- gp + theme(axis.text.x = element_text(angle = 45, hjust = 1))
print(gp)