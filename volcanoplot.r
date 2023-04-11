library(ggplot2)

data <- aco273_75_genic
##Identify the genes that have a p-value < 0.05
data$threshold = as.factor(data$P.value < 0.05)

##Construct the plot object
g <- ggplot(data=data, 
            aes(x=log2(FC), y =-log10(P.value), 
                colour=threshold)) +
  geom_point(alpha=0.4, size=1.75) +
  #xlim(c(-20, 20)) + #ylim(c(0, 1000)) +
  xlab("log2 fold change") + ylab("-log10 p-value") +
  theme_bw() +
  theme(legend.position="none")

g
