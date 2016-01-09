#
# 10K_replicate_fit.R 21 Nov 13
#
# Data from:
# An Experiment in Software Reliability
# Janet R. Dunham and John L. Pierce
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

MAX_BREW=8

brew_col=rainbow(MAX_BREW)


tests=read.csv(paste0(ESEUR_dir, "reliability/19860020075-10.csv.xz"), as.is=TRUE)
tests$F20=NULL

T1=subset(tests, tests$Task == 1)
T1$Task=NULL

T3=subset(tests, tests$Task == 3)
T3$Task=NULL

T3$F3=NULL
T3$F4=NULL
T3$F7=NULL


library("lme4")
library("reshape2")

T1_sort=data.frame(apply(T1[ , 2:9], 1, sort, na.last=TRUE))
T1_sort$failures=1:nrow(T1_sort)

T1_vec=melt(T1_sort, id.vars="failures",
		variable.name="replication", value.name="input_count")

f_mod=glmer(input_count ~ failures+ (1+failures | replication), data=T1_vec,
		family=poisson)
print(summary(f_mod))

