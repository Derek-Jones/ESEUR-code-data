#
# BSD-ts.R, 24 Jan 16
#
# Data from:
#
# A statistical examination of the properties and evolution of libre software
# Israel Herraiz Tabernero
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

library("plyr")


freebsd=read.csv(paste0(ESEUR_dir, "regression/Herraiz-freebsd.txt.xz"), as.is=TRUE)
netbsd=read.csv(paste0(ESEUR_dir, "regression/Herraiz-netbsd.txt.xz"), as.is=TRUE)
postgresql=read.csv(paste0(ESEUR_dir, "regression/Herraiz-postgresql.txt.xz"), as.is=TRUE)


plot_acf=function(lines)
{
sloc_diff=diff(lines)

t=acf(sloc_diff, lag=175, plot=FALSE)
plot(t, xlab="Lag (days)")

weeks=aaply(seq(1, length(lines), by=7), 1,
			function(X) sum(lines[X:(X+6)], na.rm=TRUE))

t=acf(diff(weeks), plot=FALSE)
plot(t, xlab="Lag (weeks)")
}

plot_acf(freebsd$sloc)
# plot_acf(netbsd$sloc)
# plot_acf(postgresql$sloc)

