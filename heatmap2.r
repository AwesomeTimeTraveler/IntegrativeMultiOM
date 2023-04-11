# Load required libraries
library(dplyr)
library(tidyr)
library(ComplexHeatmap)
install.packages("plotly")

# Create a sample dataset with two columns
data <- data.frame(
  change_methylation_A = annotated_mus_D12_5vs3mo$`Delta Avg.Mus.12.5_Avg.Mus.3mo`,
  change_methylation_B = annotated_aco_D20vsD273_75$`Delta 273.75 - 20`)
data <- as.matrix(data)

# Normalize the data using the first column as the reference
normalized_data <- data.frame(
  reference = data$change_methylation_A,
  comparison = data$change_methylation_B - data$change_methylation_A
)

parsed <- data.frame(
  reference = data$change_methylation_A,
  comparison = data$change_methylation_B
)
# Sort the normalized_data by the reference column (change_methylation_A) in descending order
normalized_data <- normalized_data[order(- normalized_data$reference),]

# Sort the non-normalized data by the reference column, in descending order
parsed <- parsed[order(- parsed$reference),]
parsed <- as.matrix(parsed)

# Generate a heatmap with a legend indicating column names
heatmap <- Heatmap(parsed,
                   name = "Delta Beta",
                   show_column_names = TRUE,
                   cluster_rows = TRUE,
                   cluster_columns = FALSE)

draw(heatmap, heatmap_legend_side = "bottom")
