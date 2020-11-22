#
# tcheck98.R, 11 May 15
#
# Data from:
# A Controlled Experiment to Assess the Benefits of Procedure Argument Type Checking
# Lutz Prechelt and Walter F. Tichy
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human argument_type-check


source("ESEUR_config.r")

library("lme4")
library("car")


# subject,checking,problem,ordering,score
tcheck=read.csv(paste0(ESEUR_dir, "experiment/tcheck98.csv.xz"), as.is=TRUE)

AB=read.csv(paste0(ESEUR_dir, "experiment/AB.data.csv.xz"), as.is=TRUE)

#tch_mod=lmer(minutes ~ (checking+problem+ordering)^2+(checking+problem+ordering | subject),
tch_mod=lmer(minutes ~ checking+problem+ordering+(checking+problem+ordering | subject),
		data=tcheck)
summary(tch_mod)

Anova(tch_mod)

