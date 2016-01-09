#
# power-law.R, 14 Dec 15
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("poweRlaw")


bench=read.csv(paste0(ESEUR_dir, "regression/src-id.csv.xz"), as.is=TRUE)

pal_col=rainbow(3)

