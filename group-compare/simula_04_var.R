#
# simula_04_var.R,  5 Jul 15
#
# Data from:
# Eliminating Over-Confidence in Software Development Effort Estimates
# Magne J{\o}rgensen and Kjetil Mol{\o}kken
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones



source("ESEUR_config.r")


library("coin")


# Team,Group,Estimate,Minimum,Maximum
est=read.csv(paste0(ESEUR_dir, "group-compare/simula_04.csv.xz"), as.is=TRUE)


A=subset(est, Group == "A")$Estimate
centered=data.frame(est=A-mean(A), group="A")
B=subset(est, Group == "B")$Estimate
centered=rbind(centered, data.frame(est=B-mean(B), group="B"))

ansari_test(est ~ as.factor(group), data=centered)

ansari_test(Estimate ~ as.factor(Group), data=est)


