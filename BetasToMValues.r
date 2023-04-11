#if (!require("BiocManager", quietly = TRUE))
    #install.packages("BiocManager")
#BiocManager::install("sesame")

library(sesame)
library(dplyr, warn.conflicts = FALSE)

#load("./Methylation Analysis/Rdata/all_probes_sesame_normalized.Rdata")

# load tibble of all probes
aco_betas = read.csv("./Methylation Analysis/spreadsheets/aco_compiled.csv")
mus_betas = read.csv("./Methylation Analysis/spreadsheets/mus_compiled.csv")
#normalized_betas = readRDS("./Methylation Analysis/Rdata/betas.Rds")

transposed_normalized_M = data.frame()
x = ncol(mus_betas)
#iterate over samples
for( i in 2:x){
  betas_vec = pull(mus_betas, i)
  transposed_normalized_M <- rbind(transposed_normalized_M, BetaValueToMValue(betas_vec))

}
# transpose output of BetaValueToMValue back to orientation of input
normalized_M_transpose_mus = t(transposed_normalized_M)

write("normalized_M_transpose_mus", file = "./Methylation Analysis/Rdata/normalized_M_transpose_mus.Rdata")
write.csv(normalized_M_transpose_mus, "normalized_M_sesame_MUS.csv", row.names = FALSE)










# make a vector out of normalized_betas_sesame
# normalized_betas_sesame_vector_2 = as.vector(normalized_betas_sesame[1:118])
