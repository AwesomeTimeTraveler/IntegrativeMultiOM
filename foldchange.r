library(tidyverse)
library(gtools)
library(countdata)
library(dplyr)

#testDir= "C:/Users/theaw/OneDrive/Desktop/Aging/Methylation Analysis"
setwd(testDir)

data <- mus_betas
sample_a <- pull(data, 2)
sample_b <- pull(data, 4)

euclidian <- function(a, b) sqrt(sum((a - b)^2))
vec_concat <- rbind(c(sample_a), c(sample_b))

foldchange_vec = data.frame()

for(i in 1:nrow(data)){
  foldchange_vec <- rbind(foldchange_vec, ((sample_b[i] - sample_a[i]) / sample_a[i] ))
}

FC_12.5_90 = foldchange_vec$X0.00653261773950453
FC_betas_mus = data.frame(FC_12.5_18.5, FC_12.5_90)
write.csv(FC_betas_mus, "FC_Betas_Mus.csv", row.names = FALSE)












load("./Rdata/all_probes_sesame_normalized (1).Rdata")
aco_compiled = read.csv("./aco_compiled.csv")
mus_compiled = read.csv("./mus_compiled.csv")

aco_compiled <- normalized_M_transpose
mus_compiled <- normalized_M_transpose_mus
mus_compiled = read.csv("./mus_compiled.csv")

aco_data <- as_tibble(aco_compiled)
mus_data <- as_tibble(mus_compiled)

sample_a = aco_data %>% pull("Avg.Aco.20")
sample_c = aco_data %>% pull("Avg.Aco.182.5")

sample_a = pull(aco_data, 1)
sample_b = pull(mus_data, 2)




















x = nrow(sample_a)
column = ncol(mus_data)

sample_b = pull(aco_data, 3)

for(i in 1:37554){
  foldchange_vec_dir <- rbind(foldchange_vec_dir, ((sample_b[i] - sample_a[i]) / sample_a[i] ))
  
}

sample_b = pull(aco_data, 4)
for(i in 1:37554){
  foldchange_vec_dirrr <- rbind(foldchange_vec_dirrr, ((sample_b[i] - sample_a[i]) / sample_a[i] ))
  
}


vec_concat <- data.frame("AcoD20"= c(foldchange_vec),
                         "AcoD"=c(foldchange_vec_dir),
                         "AcoD273.5"=c(foldchange_vec_dirrr))

write.csv(vec_concat, "FC_M_Aco.csv", row.names = FALSE)

for(i in 1:37554){
  
  for(j in 1:column){
    foldchange_vec <- rbind(foldchange_vec, ((sample_b[i] - sample_a[i]) / sample_a[i] ))
  }
  
}

X = pull(vec_concat, 1)
mu_a = mean(X, na.rm = TRUE)

p_value = data.frame(matrix)
for(i in 1:37554){
  p_value <- rbind(pvalue, t.test(foldchange_vec[i], foldchange_vec_dir[i], paired = TRUE))
}



mu_a = mean(sample_a, trim=0, na.rm = FALSE)
mu_b = mean(sample_b, trim=0, na.rm = FALSE)
mu_fc = mean(foldchange_vec_dir, trim=0, na.rm=FALSE)


ttestMouse <- function(grp1, grp2) {
  x = grp1
  y = grp2
  x = as.numeric(x)
  y = as.numeric(y)  
  results = t.test(x, y)
  results$p.value
}
rawpvalue = apply(rat, 1, ttestRat, grp1 = c(1:6), grp2 = c(7:11))




foldchange_vec_dir = rbind((sample_c[i] - sample_a[i]) / sample_a[i] )

for(i in 1:nrow(aco_data)){
  foldchange_vec_dir[i] = rbind((sample_c[i] - sample_a[i]) / sample_a[i] )
  #computed[i] = rbind(eucl(idian(sample_a[i], sample_b[i]))
  #p_value = rbind(t.test(sample_a[i], sample_b[i]))
}
write.csv(foldchange_vec_dir, "foldchange_A20-182.5.csv", row.names = FALSE)


fc_concat = concat(foldchange_data, computed)


write.csv(foldchange_vec_dir, "foldchange_A20-182.5.csv", row.names = FALSE)

write.csv(computed, "musd12.5vs3mo_foldchange.csv", row.names = FALSE)
write.csv(se, "sample_id.csv")

write.csv(normalized_betas_sesame, "normalized_betas_sesame.csv")


#df$score <- apply(df[,2:4], 1, function(x) mean(dist(x))) 
#sample_a = my_data %>% pull("205863120033_R02C01")

#avg_a(ID=my_data[,1], Means=rowMeans(my_data[,-1]))




pValue <- numeric(0)
for(i in seq(nrow(methySample)))
  pValue  <-  c(pValue,
                t.test(methySample[i,caseFields],
                       methySample[i,controlFields])$p.value)


