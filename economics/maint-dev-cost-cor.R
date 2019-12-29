#
# maint-dev-cost-cor.R, 10 Jul 17
# Data from:
# An Investigation of the Factors Affecting the Lifecycle Costs of COTS-Based Systems
# Laurence Michael Dunn
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG


source("ESEUR_config.r")


library("boot")


dev_maint_cor=function(dev_effort, indices)
{
t=cor.test(dme$maint.effort[indices], dev_effort[indices],
            method="spearman")$estimate
}


dme=read.csv(paste0(ESEUR_dir,"economics/dev-maint-effort.csv.xz"), as.is=TRUE)


# hist(log(dme$maint.effort))
# hist(log(dme$dev.effort))


maint_boot=boot(dme$dev.effort, dev_maint_cor, R = 4999)

mean(maint_boot$t)
sd(maint_boot$t)

boot.ci(maint_boot)

t=cor.test(dme$maint.effort, dme$dev.effort, method="spearman")

print(t$estimate)

