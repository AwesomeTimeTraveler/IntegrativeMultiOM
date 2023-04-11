# distribution

hist(annotated_mus_D12_5vs3mo$`Delta Avg.Mus.12.5_Avg.Mus.3mo`)
d <- density(annotated_mus_D12_5vs3mo$`Delta Avg.Mus.12.5_Avg.Mus.3mo`)
plot(d, main="Distribution of Delta B for Mus 12.5-3mo")
polygon(d, col="pink", border="blue")

hist(annotated_aco_D20vsD273_75$`Delta 273.75 - 20`)
d2 <- density(annotated_aco_D20vsD273_75$`Delta 273.75 - 20`)
plot(d2, main="Distribution of Delta B for Aco 20-273.75")
polygon(d2, col="pink", border="blue")
