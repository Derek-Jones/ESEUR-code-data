#
# mozilla.R,  1 Mar 16
#
# Data from:
# Modeling the effect of size on defect proneness for open-source software
# A. Günes Koru and Dongsong Zhang and Hongfang Liu
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("foreign")
library("survival")

plot_layout(1, 2)

moz=read.arff(paste0(ESEUR_dir, "survival/class_size/mozilla4.arff.xz"))

moz$t=moz$end-moz$start

size_mod=glm(event ~ log(size)+t, data=moz, family="binomial")
summary(size_mod)


cox_mod=coxph(Surv(start, end, event) ~ size+strata(state)+cluster(id), data=moz)

scatter.smooth(moz$size, resid(cox_mod))

