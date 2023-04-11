# load required packages
library(tidyverse)

# read in data from file
data <- mus_betas

# specify the column names to use
col1 <- colnames(data)[2]
col2 <- colnames(data)[4]

# calculate the delta and create a new data frame for it
delta <- data %>%
  transmute(!!paste0(col1, "_", col2) := !!sym(col2) - !!sym(col1))

# output the results to a new file
write_csv(delta, "delta3mo.csv")


# calculate the delta and create a new column for it
data <- data %>%
  mutate(delta = !!sym(col2) - !!sym(col1))

# create a new column indicating positive or negative change
data <- data %>%
  mutate(change = ifelse(delta > 0, "positive", "negative"))

