#
# 1304.5257.R, 25 Jul 16
# What Makes Code Hard to Understand?
# Michael Hansen and Robert L. Goldstone and Andrew Lumsdaine
#
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("lme4")

# None of this works out

#id,exp_id,base,version,grade_value,grade_category,started,ended,response_duration,py_years,prog_years,age,degree,gender,location,code_lines,duration,response_percent,common

pyperf=read.csv(paste0(ESEUR_dir, "developers/misc/1304.5257.csv.xz"), as.is=TRUE)

pyperf$lpy_years=log(pyperf$py_years+0.001)
pyperf$lprog_years=log(pyperf$prog_years+0.001)
pyperf$lcode_lines=log(pyperf$code_lines)

plot(~ response_duration + prog_years+py_years+grade_value, data=pyperf)


gp_mod=glmer(grade_value ~ prog_years+lcode_lines+response_duration
				+(response_duration | exp_id),
		data=pyperf, family=poisson)


