#
# piracy_HICSS-2010.R, 16 Nov 17
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pir=read.csv(paste0(ESEUR_dir, "economics/piracy_HICSS-2010.csv.xz"), as.is=TRUE)

USA=subset(pir, Country == "USA")

# TODO


