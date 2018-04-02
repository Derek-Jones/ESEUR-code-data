#
# Computer-Language_u64q.R,  3 Mar 18
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("lme4")


cl=read.csv(paste0(ESEUR_dir, "benchmark/Computer-Language_u64q.csv.bz2"), as.is=TRUE)

cl_mod=glm(log(cpu.s.) ~ name+lang, data=cl)
summary(cl_mod)

cm_mod=lmer(log(cpu.s.) ~ lang +(1 | name), data=cl)
summary(cm_mod)

