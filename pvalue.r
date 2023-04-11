# calculate the p value between two different columns within the same row
# iterate over the length of all the rows in the spreadsheet
# output the p value as a new column in the spreadsheet titled " p value"

install.packages("xlsx", "stats")
# load the required packages
#library(xlsx)
#library("stats")

# read in the spreadsheet
#data <- read.xlsx("annotated_aco_D20vsD273.75.xlsx", sheetIndex = 1)

data <- FC_betas_mus

# create a new column in the spreadsheet to store the p value
data$`p value` <- NA

# iterate over the length of all the rows in the spreadsheet
for (i in 1:nrow(data)) {
  # calculate the p value between the two columns
  p <- t.test(data[i, 1], data[i, 2])$p.value
  # store the p value in the new column
  data[i, "p value"] <- p
}

#  p <- t.test(data[i, "column1"], data[i, "column2"])$p.value


# write the spreadsheet back to disk
write.xlsx(data, "aco_D20vsD273.75_pvalue.xlsx", sheetName = "AcoD20vsD273.75", row.names = FALSE)
