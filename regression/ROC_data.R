#
# ROC_data.R, 26 Jul 16
#
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("ascii")


p_n=read.csv(paste0(ESEUR_dir, "regression/ROC_curve.csv.xz"), as.is=TRUE)


print(ascii(t(p_n), include.rownames=FALSE, digits=2,
	align="c", frame="topbot", grid="none"))


