#
# fse-08.R, 28 Sep 20
# Data from:
# An Empirical Study of the Effect of Time Constraints on the Cost-Benefits of Regression Testing
# Hyunsook Do and Siavash Mirarab and Ladan Tahvildari and Gregg Rothermel
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG testing_regression testing_cost

source("ESEUR_config.r")


library("reshape2")

#
# time is the percentage reduction from running the full suite.
#
fse=read.csv(paste0(ESEUR_dir, "reliability/fse-08.csv.xz"), as.is=TRUE)

# Programs were mutated to create 10 faults,
# to something like a beta regression should be used.
# But there are many counts and performance rarely gets close to 10,
# and poisson keeps life 'simple'.
# ff_mod=glm(faults_found ~ tech*time, data=fse, family=poisson)
# ff_mod=glm(faults_found ~ tech+time+version, data=fse, family=poisson)
ff_mod=glm(faults_found ~ program*(tech+time+version), data=fse, family=poisson)
summary(ff_mod)


