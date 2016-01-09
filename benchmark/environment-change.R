#
# environment-change.R, 18 Nov 15
#
# Data extracted from:
#
# We have it easy, but do we have it right?
# Todd Mytkowicz and Amer Diwan and Matthias Hauswirth and Peter F. Sweeney
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("gplots")

# A package containing a plotCI function that may be loaded during build
unloadNamespace("Rcapture")

ngs=read.csv(paste0(ESEUR_dir, "benchmark/ngs08.csv.xz"), as.is=TRUE)

plotCI(ngs$x, ngs$y, li=ngs$y.conf.min, ui=ngs$y.conf.max,
	col="red", barcol="gray", gap=0.5,
	xlab="Characters added to the environment",
		 ylab="Percentage performance difference")

