dtc <- raw.data[,-c(1,3,4,5,6,9,10,11,12,13,14,15,16,17,18,19,20,21,22,29,30,31,32,33,34,35,36,37)]

date_format <- "%m/%d/%Y %H:%M:%S"
dtc[,"BGN_DATE"] <- as.Date(dtc[,"BGN_DATE"], date_format)
dtc$year <- as.POSIXlt(dtc[,"BGN_DATE"])$year+1900



exp <- c("k", "K", "m", "M", "b", "B", "", NA)
table(dtc$CROPDMGEXP %in% exp)
table(dtc$PROPDMGEXP %in% exp)
dtc <- dtc[dtc$PROPDMGEXP %in% exp &
           dtc$CROPDMGEXP %in% exp,]
dtc$PROPDMGEXP <- factor(dtc$PROPDMGEXP)
dtc$CROPDMGEXP <- factor(dtc$CROPDMGEXP)
dtc$PROPDMGNUM <- mapply(makenum, dtc$PROPDMG, dtc$PROPDMGEXP)
dtc$CROPDMGNUM <- mapply(makenum, dtc$CROPDMG, dtc$CROPDMGEXP)
dtc$TOTALDMG <- dtc$CROPDMGNUM + dtc$PROPDMGNUM
