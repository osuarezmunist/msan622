# Problem 0 (setup):
genre <- rep(NA, nrow(movies))
count <- rowSums(movies[, 18:24])
genre[which(count > 1)] = "Mixed"
genre[which(count < 1)] = "None"
genre[which(count == 1 & movies$Action == 1)] = "Action"
genre[which(count == 1 & movies$Animation == 1)] = "Animation"
genre[which(count == 1 & movies$Comedy == 1)] = "Comedy"
genre[which(count == 1 & movies$Drama == 1)] = "Drama"
genre[which(count == 1 & movies$Documentary == 1)] = "Documentary"
genre[which(count == 1 & movies$Romance == 1)] = "Romance"
genre[which(count == 1 & movies$Short == 1)] = "Short"
movies$genre <-genre
movies <-subset(movies, budget > 0)

# Problem 1:
plot1 <- ggplot(movies,aes(x=budget,y=rating))+geom_point()+ggtitle("Budget X Rating")+xlab("Budget")+ylab("Rating")+scale_x_continuous(labels = dollar)
plot1 <- plot1 
plot(plot1)
ggsave(file="hw1-scatter.png", plot = plot1)

# Problem 2:
plot2 <- ggplot(movies, aes(factor(genre)))+ geom_bar(stat="bin") 
plot2 <- plot2 +  theme(panel.grid.major.x=element_blank())+  theme(panel.grid.minor.y=element_blank())
plot2 <- plot2 +ggtitle("Genre Frequency Distribution")+xlab("Genre")+ylab("Count")
plot(plot2)
ggsave(file="hw1-bar.png", plot = plot2)

# Problem 3:
plot3 <- ggplot(movies,aes(x=budget,y=rating))+geom_point()+ggtitle("Budget vs. Rating")+xlab("Rating")+ylab("Budget")+scale_x_continuous(labels = comma)+ facet_wrap(~ genre)
plot3 <- plot3 +  theme(panel.grid.major.x=element_blank())+  theme(panel.grid.minor.y=element_blank())
plot3 <- plot3 +ggtitle("Budget X Rating for Each Genre") +xlab("Budget in $100,000")+ylab("Rating") 
hundredk_formatter <- function(x) { return(sprintf("$%d",round(x/100000)))}
plot3 <- plot3 + scale_x_continuous(label = hundredk_formatter)
plot(plot3)
ggsave(file="hw1-multiples.png", plot = plot3)

# Problem 4:
eu <- transform(data.frame(EuStockMarkets), time = time(EuStockMarkets))
plot4 <- ggplot(eu, aes(time))+ geom_line(aes(y = DAX, colour = "DAX")) + geom_line(aes(y = SMI, colour = "SMI")) +geom_line(aes(y = FTSE, colour = "FTSE")) +geom_line(aes(y = CAC, colour = "CAC")) 
plot4 <- plot4 +ggtitle("Value Major EU Stock Indexes 1991-1999")+xlab("Year")+ylab("Value")
plot4 <- plot4+ scale_color_brewer(type="qual", palette = "Set1")
plot(plot4)
ggsave(file="hw1-multiline.png", plot = plot4)

