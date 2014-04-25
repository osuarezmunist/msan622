require(scales)
require(Seatbelts)
require(stats)



sb <- data.frame(Seatbelts)
sb$ct <-1:192
sb$year <- 1969+floor((sb$ct-1)/12)
sb$month <- rep(1:12)
sb$year.month <- sb$year+ sb$month/12
sb$total <- sb$drivers+sb$front+sb$rear
sb$harmperkm <- sb$total/sb$kms
sb$harmperkm <- sb$total/sb$kms
sb$DriversKilledkm <- sb$DriversKilled/sb$kms

# First, look at different variables 
sbm <- data.frame(sb[,c(1:4,7)])
#sbm <- data.frame(scale(sbm))
sbm$ct <-1:192
sbm$year <- 1969+floor((sbm$ct-1)/12)
sbm$month <- rep(1:12)
sbm$year.month <- sbm$year+ sbm$month/12


#sbm$total <- sbm$drivers+sbm$front+sbm$rear
sbm <- melt(sbm,id=c(6:9))
#, color=factor(variable)
p <- ggplot(sbm, aes(x=year.month,y=value,color=factor(variable,
        labels=c("Drivers Killed","Drivers Hurt","Front Seat Passengers Hurt",
        "Rear Seat Passengers Hurt","Van Drivers Killed"))))
p <- p +geom_line()
# +facet_grid(variable ~ .)
p <- p + ggtitle("Monthly Incidents in England 1969-1984") 
p <- p + xlab("Year") + ylab("Number of Incidents")
p <- p+ labs(colour="Incident Type")
p <- p + xlim(1969,1985)
p<- p  + geom_vline(xintercept = 1983.1)
plot(p)
ggsave(filename = "MUltivariateTS.png")


#! use color for law ,color=factor(law)
# + geom_smooth(method=lm,se=FALSE) 
p <- ggplot(sb, aes(x=year.month,y=DriversKilledkm, 
                    color=factor(law, labels=c("No Seatbelt Law","Seatbelt Law"))))
p <- p +geom_area()
p<- p  + geom_vline(xintercept = 1983.1)
p <- p + ggtitle("Monthly Driver Deaths per KM Driven in England 1969-1984") 
p <- p + xlab("Year") + ylab("Number of Deaths per KM")
p <- p+ labs(colour="Period")
p <- p + xlim(1969,1985)
p <- p + theme(legend.position=c(1,1),legend.justification=c(1,1))
 plot(p)

ggsave(filename = "Timeline.png")


p<-ggplot (sb, aes (x=month, y=year)) 
p<- p + geom_point (aes (x=factor(month, levels=c(1:12)), color=factor(law, labels=c("No Seatbelt Law","Seatbelt Law")),size=DriversKilledkm)) 
p<- p + coord_polar()
p <- p + ggtitle("Monthly Driver Deaths per KM Driven in England 1969-1984") 
p <- p + xlab("Month") + ylab("Year")
p <- p+ labs(colour="Period") + labs(size="Deaths")
plot(p)

ggsave(filename = "Star.png")
