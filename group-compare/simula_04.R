#
# simula_04.R,  2 Dec 15
#
# Data from:
# Eliminating Over-Confidence in Software Development Effort Estimates
# Magne J{\o}rgensen and Kjetil Mol{\o}kken
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones



source("ESEUR_config.r")



# Team,Group,Estimate,Minimum,Maximum
est=read.csv(paste0(ESEUR_dir, "group-compare/simula_04.csv.xz"), as.is=TRUE)

plot(density(subset(est, Group =="A")$Estimate), col="red", main="",
	xlim=range(est$Estimate), ylim=c(0, 9e-4),
	xlab="Amount estimated")
lines(density(subset(est, Group !="A")$Estimate), col="blue")


