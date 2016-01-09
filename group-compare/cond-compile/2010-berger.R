#
# 2010-berger.R, 23 Dec 15
#
# Data from:
# Feature-to-Code Mapping in Two Large Product Lines
# Thorsten Berger and Steven She and Krzysztof Czarnecki and Andrzej W\c{a}sowski
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


# library("dgof")
# library("fitdistrplus")
# library("kSamples")
# library("WRS")



FreeBSD=read.csv(paste0(ESEUR_dir, "group-compare/cond-compile/FreeBSD-PC.csv.xz"), as.is=TRUE)
Linux=read.csv(paste0(ESEUR_dir, "group-compare/cond-compile/Linux-PC.csv.xz"), as.is=TRUE)

pal_col=rainbow(2)

FreeBSD_count=rep(FreeBSD$features, times=FreeBSD$count)
Linux_count=rep(Linux$features, times=Linux$count)

plot(table(Linux_count), col=pal_col[1],
	xlim=c(0, 8),
	xlab="Number of features", ylab="Occurrences\n")
lines(table(FreeBSD_count), col=pal_col[2], type="h")

# L_dist=descdist(Linux_count, discrete=TRUE, boot=100)
# F_dist=descdist(FreeBSD_count, discrete=TRUE, boot=100)

# From WRS
# ks(Linux_stand, FreeBSD_stand)


# dgof::ks.test uses stats::ecdf internally, but without the qualified name.
# WRS defines its own ecdf function, so both packages do not coexist!
# One of the arguments has to be the empirical cumulative distribution function

# detach("package:WRS", unload=TRUE)
# dgof::ks.test(Linux_stand,
# 	ecdf(FreeBSD_stand))

