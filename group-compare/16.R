#
# 16.R, 11 Nov 15
#
# Data from:
#
# A Case Study Research on Software Cost Estimation Using Experts? Estimates, Wideband Delphi, and Planning Poker Technique
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(3)

est_1=read.csv(paste0(ESEUR_dir, "group-compare/16_1.csv.xz"), as.is=TRUE)

plot(est_1$actual.cost, est_1$expert, col=pal_col[1])
points(est_1$actual.cost, est_1$wideband.Delphi, col=pal_col[2])
lines(c(20, 120), c(20, 120))


est_2=read.csv(paste0(ESEUR_dir, "group-compare/16_2.csv.xz"), as.is=TRUE)

plot(est_2$actual.cost, est_2$expert, col=pal_col[1])
points(est_2$actual.cost, est_2$planning.poker, col=pal_col[2])
lines(c(20, 120), c(20, 120))



