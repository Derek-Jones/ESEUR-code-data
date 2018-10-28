#
# Maint_Dec2005.R, 28 Oct 18
# Data from:
# How accurately do engineers predict software maintenance tasks?
# Les Hatton
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG maintenance estimating


source("ESEUR_config.r")


library("compositions")
library("plyr")


maint=read.csv(paste0(ESEUR_dir, "economics/exportdata.csv.xz"), as.is=TRUE)


est_comp=acomp(maint+1e-57, parts=c("est_adapt",
                        "est_correct",
                        "est_perfect"))
act_comp=acomp(maint+1e-57, parts=c("act_adapt",
                        "act_correct",
                        "act_perfect"))

# plot(act_comp, col="red", colMissingTck="red", labels="", mp=NULL)
# plot(est_comp, col="green", colMissingTck="green", add=TRUE, labels="", mp=NULL)
# ternaryAxis(side=0, small=TRUE, aspanel=TRUE,
#                 Xlab="Adaptive", Ylab="Corrective", Zlab="Perfective")

# A fit that does not fit
# comp_mod=lm(ilr(act_comp) ~ ilr(est_comp)+est_time, data=maint)
# summary(comp_mod)

# mcov(est_comp, act_comp)

# Point size depending on number of measurements at each point
est_cnt=count(maint, vars=c("est_adapt",
                        "est_correct",
                        "est_perfect"))
act_cnt=count(maint, vars=c("act_adapt",
                        "act_correct",
                        "act_perfect"))

# Adding a very small value ensures that no points are treated as contining
# a missing value (which are plotted differently).
est_comp=acomp(est_cnt+1e-7, parts=c("est_adapt",
                        "est_correct",
                        "est_perfect"))
act_comp=acomp(act_cnt+1e-5, parts=c("act_adapt",
                        "act_correct",
                        "act_perfect"))

plot(act_comp, pch=21, cex=1+sqrt(act_cnt$freq), col="red", colMissingTck="red", labels="", mp=NULL)
plot(est_comp, pch=21, cex=1+sqrt(est_cnt$freq), col="green", colMissingTck="red", add=TRUE, labels="", mp=NULL)
ternaryAxis(side=0, small=TRUE, aspanel=TRUE,
                Xlab="Adaptive", Ylab="Corrective", Zlab="Perfective")

