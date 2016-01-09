#
# 1408_full.R, 22 Mar 15
#
# Data from:
#
# Cleaned up the original data a bit...
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


devknow=read.csv(paste0(ESEUR_dir, "developers/1408_full-311213.csv.xz"), as.is=TRUE)

pal_col=rainbow_hcl(3)

