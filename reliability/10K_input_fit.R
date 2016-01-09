#
# 10K_input_fit.R 20 Nov 13
#
# Data from:
# An Experiment in Software Reliability
# Janet R. Dunham and John L. Pierce
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("reshape2")


tests=read.csv(paste0(ESEUR_dir, "reliability/19860020075-10.csv.xz"), as.is=TRUE)

T1=subset(tests, tests$Task == 1)
T1$Task=NULL

T3=subset(tests, tests$Task == 3)

T3$Task=NULL
T3$F3=NULL
T3$F4=NULL
T3$F7=NULL
T3$F20=NULL

# Ignore the first two faults
T1_sort=data.frame(apply(T1[ , 4:9], 2, sort, na.last=TRUE))
T1_sort$index=1:nrow(T1_sort)

t1=melt(T1_sort, id.vars="index", variable.name="fault_id", value.name="input_count")

f1_mod=glm(input_count ~ fault_id+index, data=t1, family=poisson)
print(summary(f1_mod))

# Ignore two faults
T3$F1=NULL
T3$F19=NULL
T3_sort=data.frame(apply(T3, 2, sort, na.last=TRUE))
T3_sort$index=1:nrow(T3_sort)

t2=melt(T3_sort, id.vars="index", variable.name="fault_id", value.name="input_count")

#f2_mod=glm(input_count ~ fault_id+index, data=t2, family=poisson)
#summary(f2_mod)

