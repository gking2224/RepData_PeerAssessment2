byinjuries <- as.data.frame(tapply(dtc$INJURIES, dtc$EVTYPE, sum))
byinjuries$EVTYPE<-row.names(byinjuries)
byinjuries <- byinjuries[order(byinjuries[1], decreasing=TRUE),]
names(byinjuries) <- c("injuries", "evtype")
row.names(byinjuries) <- NULL
byfatalities <- as.data.frame(tapply(dtc$FATALITIES, dtc$EVTYPE, sum))
byfatalities$EVTYPE<-row.names(byfatalities)
byfatalities <- byfatalities[order(byfatalities[1], decreasing=TRUE),]
names(byfatalities) <- c("fatalities", "evtype")
row.names(byfatalities) <- NULL

library(ggplot2)
library(gridExtra)
gi <- ggplot(byinjuries[1:10,], aes(x=evtype, y=injuries))
gi <- gi + geom_bar(stat="identity")
gi <- gi + xlab("Weather Event Type") + ylab("Injuries")
gi <- gi + theme(axis.text.x = element_text(angle = 45, hjust = 1))

gf <- ggplot(byfatalities[1:10,], aes(x=evtype, y=fatalities))
gf <- gf + geom_bar(stat="identity")
gf <- gf + xlab("Weather Event Type") + ylab("Fatalities")
gf <- gf + theme(axis.text.x = element_text(angle = 45, hjust = 1))

grid.arrange(gi, gf, nrow=2,
             main="Figure 2: Health impact of US weather events (1995-2011)")

