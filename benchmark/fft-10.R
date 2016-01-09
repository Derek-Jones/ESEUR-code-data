#
# fft-10.R, 10 Dec 13
#
# Data from:
# benchmark precision and random initial state
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("reshape2")

fft=read.csv(paste0(ESEUR_dir, "benchmark/fft-10.csv.xz"), as.is=TRUE)

brew_col=rainbow(10)

t=melt(fft, id.vars=NULL)
boxplot(value ~ variable, data=t, axes=FALSE,
        col=brew_col, border=brew_col,
	ylab="Time (ms)\n")

axis(2)

