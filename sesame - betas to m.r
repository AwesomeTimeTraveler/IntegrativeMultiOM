library(sesame)
library(dplyr, warn.conflicts = FALSE)

load("./Methylation Analysis/Rdata/all_probes_sesame_normalized.Rdata")

library(optimbase)
# load tibble of all probes
# comvert to matrix
# pull vector for each column, including column names
# convert to M value with BetaValueToMValue()

# load tibble of all probes
aco_betas = read.csv("./Methylation Analysis/spreadsheets/aco_compiled.csv")
mus_betas = read.csv("./Methylation Analysis/spreadsheets/mus_compiled.csv")
#normalized_betas = readRDS("./Methylation Analysis/Rdata/betas.Rds")

mus_betas_vec = pull(mus_betas, 2)
aco_betas_vec = pull(aco_betas, 2)

mus_M = t(BetaValueToMValue(mus_betas_vec))

#aco_M = BetaValueToMValue(aco_betas_vec)


#mus_M_vec = vector(mus_M_matrix)

#matches <- data.frame()
#matches = rbind(matches, mus_M)
#write.csv(matches, "mus_M.csv", row.names = FALSE)