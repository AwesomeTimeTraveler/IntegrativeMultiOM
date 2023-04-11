# load required packages
library(tidyverse)
library(broom)

# read in data
data <- aco_betas

# extract the two columns of interest
column1 <- data$Avg.Aco.20
column2 <- data$Avg.Aco.26

hist(FC_12.5_18.5)
hist(FC_12.5_90)
hist(FC_20_26)
hist(FC_20_182)
hist(FC_20_273)

plot(density(FC_12.5_18.5))
plot(density(FC_12.5_90))
plot(density(FC_20_26))
plot(density(FC_20_182))
plot(density(FC_20_273))

# Check for normal distribution
hist(column1)
hist(column2)
plot(density(column1))
plot(density(column2))

# perform Shapiro-Wilk test 
# p val < 0.05 , then we reject null and 
# conclude data is not normally disrtibuted
# limited to 5000
shapiro.test(column1)
shapiro.test(column2)

# perform t-test modification, Welch's - assuming unequal variance
ttest <- t.test(column1, column2, var.equal = FALSE)

# extract the p-value
p_value <- ttest$p.value

# calculate the degrees of freedom
df <- ttest$parameter

# calculate the t-value
t_value <- ttest$statistic

# calculate the confidence interval
conf_int <- confint(ttest)

# calculate the mean difference between the two columns
mean_diff <- mean(column1) - mean(column2)

# output results
cat("Mean difference:", mean_diff, "\n")
cat("t-value:", t_value, "\n")
cat("Degrees of freedom:", df, "\n")
cat("p-value:", p_value, "\n")
cat("Confidence interval:", conf_int, "\n")
