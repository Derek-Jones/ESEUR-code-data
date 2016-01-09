#
# CPU-vs-GPU.R,  6 Aug 13
#
# Data from:
# Where is the Data? Why You Cannot Debate GPU vs. CPU Performance Without the Answer
# Chris Gregg and Kim Hazelwood
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

bench=read.csv(paste0(ESEUR_dir, "benchmark/gtx480.csv.xz"), as.is=TRUE)

brew_col=rainbow_hcl(3)

barplot(t(as.matrix(bench[, 2:4])), 
	legend.text=c("Move data to GPU", "GPU matrix multiply", "Move result from GPU"),
	args.legend=list(x="topleft", bty="n"),
	names.arg=bench$N,
	xlab="Matrix size (N x N)", ylab="Time (msec)",
	col=brew_col)

