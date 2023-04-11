# STATS

# Load required libraries
library(dplyr)
library(tidyr)

# Create a sample dataset with one column
data <- as.matrix(annotated_mus_D12_5vs3mo$`Delta Avg.Mus.12.5_Avg.Mus.3mo`)

# Function to perform a one-sample t-test for a single change
one_sample_t_test <- function(change, mu = 0) {
  test_result <- t.test(change, mu = mu)
  return(test_result$p.value)
}

# Apply the function to each row of the dataset
p_values <- sapply(data, one_sample_t_test)

# Add p-values as a new column to the dataset
data$p_values <- p_values

# Display the dataset with p-values
print(data)


# Load required libraries
library(dplyr)
library(tidyr)

library(ggplot2)

# Create a sample dataset with one column
data <- data.frame(
  change_methylation = annotated_mus_D12_5vs3mo$`Delta Avg.Mus.12.5_Avg.Mus.3mo`
)

# Calculate descriptive statistics
mean_change <- mean(data$change_methylation)
median_change <- median(data$change_methylation)
sd_change <- sd(data$change_methylation)
iqr_change <- IQR(data$change_methylation)

cat("Mean:", mean_change, "\n")
cat("Median:", median_change, "\n")
cat("Standard Deviation:", sd_change, "\n")
cat("Interquartile Range:", iqr_change, "\n")

# Generate a histogram
ggplot(data, aes(x = change_methylation)) +
  geom_histogram(binwidth = 0.1, fill = "dodgerblue", color = "black") +
  labs(title = "Histogram of Changes in Methylation Values",
       x = "Change in Methylation Value",
       y = "Frequency") +
  theme_minimal()







# Load required libraries
library(dplyr)
library(ggplot2)

# Create a sample dataset with two columns
data <- data.frame(
  change_methylation_A = annotated_mus_D12_5vs3mo$`Delta Avg.Mus.12.5_Avg.Mus.3mo`,
  change_methylation_B = annotated_aco_D20vsD273_75$`Delta 273.75 - 20`)
)

# Reshape the data to a long format for ggplot
data_long <- data %>%
  mutate(row = row_number()) %>%
  pivot_longer(cols = -row, names_to = "group", values_to = "change_methylation")

# Generate a histogram with density curves
ggplot(data_long, aes(x = change_methylation, fill = group, color = group)) +
  #geom_histogram(aes(y = ..density..), position = "identity", alpha = 0.5, binwidth = 0.1) +
  geom_density() +
  labs(title = "Histogram and Density Plot of Changes in Methylation Values",
       x = "Change in Methylation Value",
       y = "Density") +
  theme_minimal() +
  scale_fill_manual(values = c("dodgerblue", "orange")) +
  scale_color_manual(values = c("blue", "darkorange"))
