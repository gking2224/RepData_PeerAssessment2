byinjuries <- as.data.frame(tapply(dtc$INJURIES, dtc$EVTYPE, sum))
byinjuries$EVTYPE<-row.names(byinjuries)
#byinjuries <- byinjuries[order(byinjuries[1], decreasing=TRUE),]
names(byinjuries) <- c("injuries", "evtype")
#row.names(byinjuries) <- NULL
byfatalities <- as.data.frame(tapply(dtc$FATALITIES, dtc$EVTYPE, sum))
byfatalities$EVTYPE<-row.names(byfatalities)
#byfatalities <- byfatalities[order(byfatalities[1], decreasing=TRUE),]
names(byfatalities) <- c("fatalities", "evtype")
#row.names(byfatalities) <- NULL

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
library(lattice)
bp <- barchart(count ~ evtype | type, data=hm, ylab="Number of events",
               xlab = "Weather Event Type",
               main="Health impact of US weather events (1995-2011)",
               scales=list(y=list(relation="free"),x=list(rot=90)),
               angle=90)
print(bp)