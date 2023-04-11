library(sesame)
library(parallel)
library(SummarizedExperiment)
library(tidyverse)
library(readr)

testDir2= "C:/Users/theaw/OneDrive/Desktop/Aging/Methylation Analysis/idatFiles"
#idatFiles/205863120071"

dest_dir = tempdir()
setwd(testDir2)

#complete_directory? = mclapply(searchIDATprefixes("."), readIDATpair)

s = readIDATpair("205863120071_R01C01")

sesameQC_calcStats(s)
betas = getBetas(s)
head(betas, 20)
head(s$mask)
sum(s$mask)
s0 = resetMask(s)
s1 = qualityMask(s0)
s4 = noob(s)
sesameQC_plotIntensVsBetas(s4)
sesameQC_plotRedGrnQQ(s4)
s5 = dyeBiasNL(s4)
sesameQC_plotRedGrnQQ(s5)
sesameQC_plotIntensVsBetas(s5)


##DO IT ALL WITH THE ENTIRE DATASET IN THE FOLDER, ALL GRN AND RED RECURSIVELY
betas=do.call(cbind, mclapply(searchIDATprefixes("."), function(px) getBetas(dyeBiasNL(noob(pOOBAH(readIDATpair(px)))))))
head(betas)
write.csv(betas,file="./sesame_betas_normalized.csv")

saveRDS(betas, file = "betas.rds")
# Restore the object
betas = readRDS(file = "./betas.rds")
#LOAD CSV OF STEVE'S DATA AND SET == TO DETERMINE IF THE SAME NORMALIZATION ??
# OTHER POST PROCESSING THEY WOULD DO, OR EXACT PROCESS?





if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("sesame")
BiocManager::install("ExperimentHub")
BiocManager::install("pals")
BiocManager::install("SummarizedExperiment")
BiocManager::install("tidyverse")

##Packages required for interacting with sesame data
if (!require("BiocManager"))
  install.packages("BiocManager")
BiocManager::install("GenomicRanges")
BiocManager::install("sesameData")
BiocManager::install("sesameAnno", type = "binary")


