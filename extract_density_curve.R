#
# This is the solution! Find the peaks of your distributions
# Use that to standardize the references in your statistics!
# 
# https://ianmadd.github.io/pages/PeakDensityDistribution.html
#
# https://cran.r-project.org/web/packages/ggformula/vignettes/ggformula.html
#
#

library(ggplot2)

data_aco <- data.frame(aco_betas)
data_mus <- data.frame(mus_betas)

ggplot(data_mus, aes(Avg.Mus.12.5)) + geom_density()
+ geom_density_ridges(alpha = 1, scale = 5) +
  scale_fill_manual(values = wes_palette("Darjeeling")) +
  theme_few()

which.max(density(data_aco$Avg.Aco.273.75)$y)
density(data_aco$Avg.Aco.273.75)$x[255]

ggplot(data_aco, aes(Avg.Aco.273.75)) + geom_density() + geom_vline(xintercept = density(data_aco$Avg.Aco.273.75)$x[255])
