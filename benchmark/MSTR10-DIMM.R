#
# MSTR10-DIMM.R, 11 Feb 15
#
# Data from:
# ViPZonE: Exploiting DRAM Power Variability for Energy Savings in Linux x86-64
# Mark Gottscho
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


DIMM=read.csv(paste0(ESEUR_dir, "benchmark/MSTR10-DIMM.csv.xz"), as.is=TRUE)

apply(DIMM[, -1], 2, mean)
apply(DIMM[, -1], 2, sd)

