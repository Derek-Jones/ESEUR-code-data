#
# fft-depend.R, 10 Dec 13
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

brew_col=rainbow_hcl(10)

plot(fft$r1[1:2000], fft$r1[2:2001])
acf(fft$r1)

