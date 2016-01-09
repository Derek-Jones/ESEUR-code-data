#
# mozilla.R,  5 Jan 16
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("foreign")
library("survival")

plot_layout(1, 2)

moz=read.arff(paste0(ESEUR_dir, "survival/class_size/mozilla4.arff"))

moz$t=moz$end-moz$start

pois_mod=glm(event ~ size+t, data=moz, family="poisson")


cox_mod=coxph(Surv(start, end, event) ~ size+strata(state)+cluster(id), data=moz)

scatter.smooth(moz$size, resid(cox_mod))

