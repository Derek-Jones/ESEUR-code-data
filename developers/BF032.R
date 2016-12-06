#
# BF032.R, 25 Oct 16
# Data from:
# Michiel P. {van Oeffelen} and Peter G. Vos
# A probabilistic model for the discrimination of visual number
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")

pal_col=rainbow(2)

human=read.csv(paste0(ESEUR_dir, "developers/BF032.csv.xz"), as.is=TRUE)

human=human[order(human$d), ]

plot(0, type="n",
	xlim=range(human$s+human$d), ylim=c(0.5, max(human$p)),
	xlab="Number of dots", ylab="Probability correct\n")

d_ply(human, .(s), function(df) lines(df$s+df$d, df$p, type="b", col=point_col))


