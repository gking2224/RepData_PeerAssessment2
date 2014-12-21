bydmg <- as.data.frame(tapply(dtc$TOTALDMG, dtc$EVTYPE, sum))
bydmg$EVTYPE<-row.names(bydmg)
bydmg <- bydmg[order(bydmg[1], decreasing=TRUE),]
names(bydmg) <- c("cost", "evtype")

bn <- 10^9
scale <- signif(max(bydmg$cost, na.rm=TRUE), 1) / bn
library(ggplot2)
gc <- ggplot(bydmg[1:10,], aes(x=factor(evtype), y=cost))
gc <- gc + geom_bar(stat="identity")
gc <- gc + xlab("Event Type") + ylab("Total Cost ($)")
gc <- gc + scale_y_continuous(
    breaks=bn * seq(0,scale, by=5),
    labels=paste0(seq(0,scale, by=5), "bn"),
    limits=bn * c(0,scale)
)
gc <- gc + theme(axis.text.x = element_text(angle = 90, hjust = 1))
print(gc)