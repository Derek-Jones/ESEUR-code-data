#
# 1998_005_001_16640.R, 18 Sep 16
# Data from:
# Hughes Aircraft’s Widespread Deployment of a Continuously Improving Software Process
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


bench=read.csv(paste0(ESEUR_dir, "projects/1998_005_001_16640.csv"), as.is=TRUE)


rowMeans(bench[1:8, 2:8], na.rm=TRUE)
colMeans(bench[1:7, 2:9], na.rm=TRUE)

