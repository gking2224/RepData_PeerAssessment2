#barplot(tapply(dtc$year, dtc$year, length),
#        main = "Figure 1: Number of Weather Events Recorded by Year",
#        ylab = "Total event count", xlab="Year")

yd <- as.data.frame(tapply(dtc$year, dtc$year, length))
yd$year <- row.names(yd)
row.names(yd) <- NULL
names(yd) <- c("count", "year")

ye <- ggplot(yd, aes(x=year, y=count))
ye <- ye + geom_bar(stat="identity")
ye <- ye + xlab("Year") + ylab("Observations")
ye <- ye + ggtitle("Figure 1: Total Observations per Year")
ye <- ye + theme(axis.text.x = element_text(angle = 45, hjust = 1),
                 plot.margin = unit(c(0,0,0,0), "lines"))
ga <- ggplot_build(ye)
ga$width <- 100
print(ye)

dtc <- dtc[dtc$year >=1995,]
