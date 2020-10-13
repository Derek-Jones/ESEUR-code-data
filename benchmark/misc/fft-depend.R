#
# fft-depend.R, 10 Dec 13
# Data from:
# Benchmark precision and random initial state
# Tom{\'a}\u{s} Kalibera and Lubom{\'i}r Bulej and Petr T\r{u}ma
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG benchmark_precision benchmark_initial-stte

source("ESEUR_config.r")


library("reshape2")

fft=read.csv(paste0(ESEUR_dir, "benchmark/fft-10.csv.xz"), as.is=TRUE)

brew_col=rainbow_hcl(10)

plot(fft$r1[1:2000], fft$r1[2:2001])
acf(fft$r1)

