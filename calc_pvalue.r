# Load required libraries
library(dplyr)

# Create a sample dataset with two columns
data <- data.frame(
  column1 = mus_betas$Avg.Mus.12.5,
  column2 = aco_betas$Avg.Aco.20
)

# Function to calculate the p-value using the Wilcoxon Rank Sum test
calculate_wilcox_pval <- function(x, y) {
  test_result <- wilcox.test(x, y, exact = FALSE)
  return(test_result$p.value)
}

# Apply the function to each row of the dataset
p_values <- mapply(calculate_wilcox_pval, data$column1, data$column2)

# Add p-values as a new column to the dataset
data$p_values <- p_values

#
# Permutation Test
#

# Function to perform the Permutation test for a row pair
permutation_test <- function(x, y, n_permutations = 1000) {
  observed_diff <- abs(x - y)
  combined_values <- c(x, y)
  permuted_diffs <- vector(mode = "numeric", length = n_permutations)
  
  for (i in 1:n_permutations) {
    permuted_values <- sample(combined_values, 2, replace = FALSE)
    permuted_diffs[i] <- abs(permuted_values[1] - permuted_values[2])
  }
  
  p_value <- mean(permuted_diffs >= observed_diff)
  return(p_value)
}

# Apply the function to each row of the dataset
p_values <- mapply(permutation_test, data$column1, data$column2)

# Add p-values as a new column to the dataset
data$p_values <- p_values

# Display the dataset with p-values
print(p_values)

#
# Paired T-test
#

# Perform the paired t-test
test_result <- t.test(data$column1, data$column2, paired = TRUE)

# Get the p-value
tt_p_value <- test_result$p.value

# Display the dataset with p-values
print(data)




data <- annotated_mus_D12_5vs3mo$`Delta Avg.Mus.12.5_Avg.Mus.3mo`
data <- as.matrix(data)
mu1 = mean(data)
 

# Perform one-sample t-test for each row
p_values <- apply(matrix(data, ncol=1), 1, function(x) if(sum(!is.na(x))>=2) t.test(x[!is.na(x)], mu=mu1)$p.value else NA)
print(p_values)
# Append p-values as a new column to the original data
data_with_p <- cbind(data, p_values)

# Print results
print(data_with_p)

p_values <- apply(matrix(data, ncol=1), 1, function(x) {
  non_missing <- !is.na(x)
  if(sum(non_missing) >= 2) t.test(x[non_missing], mu=0)$p.value else NA
})




# Function to calculate p-value for non-normally distributed data
calculate_ttest_p_value <- function(x) {
  t.test(x, mu=mu1, alternative="two.sided", method="wilcox.test")$p.value
}

# Calculate p-value for each row using the function
p_values <- apply(matrix(data, ncol=1), 1, calculate_ttest_p_value)






#
# Chunked Approach to Wilcox Test, to reduce RAM
#

# read in your data, assuming your data is in a data frame called 'df'
# with two columns called 'column1' and 'column2'
column1 <- mus_betas$Avg.Mus.12.5
column2 <- aco_betas$Avg.Aco.20

# define the chunk size (adjust as needed)
chunk_size <- 1000

# create a function to perform the Wilcoxon rank sum test on two vectors
wilcox_test <- function(x, y) {
  wilcox.test(x, y, alternative = "two.sided")$p.value
}

# initialize an empty data frame to store the p-values
p_values_df <- data.frame(row1 = integer(),
                          row2 = integer(),
                          p_value = numeric(),
                          stringsAsFactors = FALSE)

# iterate over the rows of column1 in chunks
for (i in seq(1, length(column1), chunk_size)) {
  chunk1 <- column1[i:min(i + chunk_size - 1, length(column1))]
  
  # iterate over the rows of column2 in chunks
  for (j in seq(1, length(column2), chunk_size)) {
    chunk2 <- column2[j:min(j + chunk_size - 1, length(column2))]
    
    # use the outer() function to apply the wilcox_test() function to all pairs of rows in the chunk
    p_values <- outer(chunk1, chunk2, wilcox_test)
    
    # convert the p_values matrix to a data frame and add row and column labels
    p_values_chunk <- data.frame(row1 = rep((i-1) + 1:length(chunk1), each = length(chunk2)),
                                 row2 = rep((j-1) + 1:length(chunk2), length(chunk1)),
                                 p_value = as.vector(p_values),
                                 stringsAsFactors = FALSE)
    
    # append the chunk p-values to the p_values_df data frame
    p_values_df <- rbind(p_values_df, p_values_chunk)
  }
}

# export the p_values data frame to a CSV file
write.csv(p_values_df, file = "p_values.csv", row.names = FALSE)
























# load required packages
library(tidyverse)

# read in your data, assuming your data is in a data frame called 'df'
# with two columns called 'column1' and 'column2'
column1 <- aco_betas$Avg.Aco.20
column2 <- mus_betas$Avg.Mus.12.5

# create an empty data frame to store the p-values
p_values <- data.frame()

# iterate over the rows of column1 and column2
for (i in 1:length(column1)) {
  for (j in 1:length(column2)) {
    # perform the Wilcoxon rank sum test on the ith row of column1 and jth row of column2
    p_val <- wilcox.test(column1[i], column2[j], alternative = "two.sided")$p.value
   
    # add the p-value to the p_values data frame
    p_values <- rbind(p_values, data.frame(row1 = i, row2 = j, p_value = p_val))
  }
}

# export the p_values data frame to a CSV file
write.csv(p_values, file = "p_values.csv", row.names = FALSE)

#
# USING outer function to parallelize vectorization, and it required a vector of 10.5GB and crashed
# SHOULD be way faster, but needs to be run on cluster
#

# read in your data, assuming your data is in a data frame called 'df'
# with two columns called 'column1' and 'column2'
column1 <- df$column1
column2 <- df$column2

# create a function to perform the Wilcoxon rank sum test on two vectors
wilcox_test <- function(x, y) {
  wilcox.test(x, y, alternative = "two.sided")$p.value
}

# use the outer() function to apply the wilcox_test() function to all pairs of rows
p_values_2 <- outer(column1, column2, wilcox_test)

# convert the p_values matrix to a data frame and add row and column labels
p_values_df_2 <- data.frame(row1 = rep(1:length(column1), each = length(column2)),
                          row2 = rep(1:length(column2), length(column1)),
                          p_value = as.vector(p_values_2))

# export the p_values data frame to a CSV file
write.csv(p_values_df_2, file = "p_values_2.csv", row.names = FALSE)







# read in data from file
data <- aco_betas

# specify the column names to use
col1 <- colnames(data)[2]
col2 <- colnames(data)[3]


calc_ranksum <- function(col) {
# perform rank sum test and create new dataframe to export p values
  p_values <- data %>%
   summarise(p_value = wilcox.test(!!sym(colomn1(col)), !!sym(column2(col)))$p.value)
  return(p_values)
}

ranksum_12_20 <- calc_ranksum(data$Avg.Aco.20, mus_betas$Avg.Mus.12.5)

#OUTPUTS TO SAME DATAFRAME
# perform rank sum test and create new column with p-values
#data <- data %>%
#  mutate(p_value = wilcox.test(!!sym(col1), !!sym(col2))$p.value)

# output data to a new file
write_csv(data, "output_file.csv")





# T-Test
# The code below assumes normality

data <- FC_betas

data$`p value 273` <- NA
data$`z score 273` <- NA

s = sd(data$FC_20_273)
n = nrow(data)
xbar <- mean(data$FC_20_273)

calc_pvalue <- function(col) {
  p_values <- pnorm(-abs(col), lower.tail = FALSE) * 2
  return(p_values)
}

calc_zscore <- function(col) {
  z_scores <- (xbar - col) / (s/sqrt(n))
  return(z_scores)
}

##Identify the genes that have a p-value < 0.05
data$threshold = as.factor(data$P.value < 0.05)










