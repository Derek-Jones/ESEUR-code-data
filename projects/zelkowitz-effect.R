#
# zelkowitz-effect.R, 26 Aug 17
# Data from:
# The Effectiveness of Software Prototyping: {A} Case Study
# Marvin V. Zelkowitz
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


effort=read.csv(paste0(ESEUR_dir, "projects/zelkowitz-effect.csv.xz"), as.is=TRUE)


