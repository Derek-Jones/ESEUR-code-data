#
# Complexity18EmpSE.R, 18 Jun 20
# Data from:
# Syntax, Predicates, Idioms -- {What} Really Affects Code Complexity?
# Shulamyt Ajami and Yonatan Woodbridge and Dror G. Feitelson
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human if-statement

source("ESEUR_config.r")


library("lme4")


srt=read.csv(paste0(ESEUR_dir, "sourcecode/Complexity18EmpSE.csv.xz"), as.is=TRUE)

srt$subject=as.character(srt$subject)

# Diffusion models of response time use log transform.

# This problem really requires a mixed-model, but glm is easier to
# go fishing with, and is close enough

rt_lmod=glm(log(RT) ~ nesting+subset+problem*correct+is_Neg, data=srt)
summary(rt_lmod)

# A non-log transformed model
rt_mod=glm(RT ~ nesting+subset+problem*correct+is_Neg, data=srt)
# rt_mod=nls(log(RT) ~ a+b*nesting^c, data=srt, start=list(a=9, b=0.2, c=0.9))
summary(rt_mod)

# Both models account for 10% of the deviance


rt_mmod=lmer(log(RT) ~ nesting+subset+problem+correct+is_Neg+
				(1 | subject)+ (correct-1 | subject), data=srt)
summary(rt_mmod)
AIC(rt_mmod)

# A call to coef returns values for every subject
# Need to fiddle around to get values of general coefficients
exp(summary(rt_mmod)$coefficients[, 1])


an_mod=glm(correct ~ nesting+subset+problem+is_Neg, data=srt, family=binomial)
summary(an_mod)

# No interaction between nesting and problem :-(
an_mmod=glmer(correct ~ nesting+subset+problem+is_Neg+
				(1 | subject)+ (problem-1 | subject),
				data=srt, family=binomial)
summary(an_mmod)
AIC(an_mmod)


