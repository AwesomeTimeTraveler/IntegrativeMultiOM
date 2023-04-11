#if (!require("BiocManager", quietly = TRUE))
  #install.packages("BiocManager")
#BiocManager::install("sesame")

library(sesame)
library(dplyr, warn.conflicts = FALSE)

load("./Methylation Analysis/Rdata/all_probes_sesame_normalized.Rdata")

# load tibble of all probes
# comvert to matrix
# pull vector for each column, including column names
# convert to M value with BetaValueToMValue()

# load tibble of all probes
aco_betas = read.csv("./Methylation Analysis/spreadsheets/aco_compiled.csv")
mus_betas = read.csv("./Methylation Analysis/spreadsheets/mus_compiled.csv")
#normalized_betas = readRDS("./Methylation Analysis/Rdata/betas.Rds")

mus_betas_vec = pull(mus_betas, 1)

#normalized_betas_sesame_vec = pull(normalized_betas_sesame, 2)

#normalized_M_sesame = BetaValueToMValue(normalized_betas_sesame_vec)



# make a vector out of normalized_betas_sesame
#normalized_betas_sesame_vector_2 = as.vector(normalized_betas_sesame[1:118])

for(i in ncol(mus_betas)){
    normalized_betas_sesame_vec = pull(mus_betas, i)
    normalized_M_sesame[ , i] = rbind(BetaValueToMValue(normalized_betas_sesame_vec))

}

# Convert Beta Values to M Values
#normalized_M_sesame = BetaValueToMValue(normalized_betas_sesame_vec)

#write("normalized_M_sesame", file = "./Methylation Analysis/Rdata/normalized_M_sesame_v2.Rdata")
#write.csv(normalized_M_sesame, "normalized_M_sesame.csv", row.names = FALSE)
