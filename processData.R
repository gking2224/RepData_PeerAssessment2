raw.data <- raw.data.full# [rbinom(nrow(raw.data.full),1,0.2)==1,]
dtc <- raw.data[,-c(1,3,4,5,6,9,10,11,12,13,14,15,16,17,18,19,20,21,22,29,30,31,32,33,34,35,36,37)]
dtc[,"BGN_DATE"] <- as.Date(dtc[,"BGN_DATE"], "%m/%d/%Y %H:%M:%S")
dtc$year <- as.POSIXlt(as.Date(dtc[,"BGN_DATE"], "%m/%d/%Y %H:%M:%S"))$year+1900
dtc <- dtc[dtc$PROPDMGEXP %in% c("B", "M", "K", "", NA) &
           dtc$CROPDMGEXP %in% c("B", "M", "K", "", NA),]
dtc$PROPDMGEXP <- factor(dtc$PROPDMGEXP)
dtc$CROPDMGEXP <- factor(dtc$CROPDMGEXP)
dtc$PROPDMGNUM <- mapply(makenum, dtc$PROPDMG, dtc$PROPDMGEXP)
dtc$CROPDMGNUM <- mapply(makenum, dtc$CROPDMG, dtc$CROPDMGEXP)
dtc$TOTALDMG <- dtc$CROPDMGNUM + dtc$PROPDMGNUM

dtc <- dtc[dtc$year >=1995,]