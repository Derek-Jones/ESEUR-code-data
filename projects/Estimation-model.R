#
# Estimation-model.R, 18 Oct 17
# Data from:
# Effort Estimation with Story Points and COSMIC Function Points - An Industry Case Study
# Christophe Commeyne and Alain Abran and Rachida Djouab
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


em=read.csv(paste0(ESEUR_dir, "projects/Estimation-model.csv.xz"), as.is=TRUE)

plot(em$Estimate, em$Entry_CFP+em$Exit_CFP+em$Read_CFP+em$Write_CFP, col=point_col, log="xy",
	xlab="Story point estimate (hours)", ylab="COSMIC FP")

