#
# 1304.5257.R, 26 Mar 15
#
# Data from:
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("lmer")

# None of this works out

#id,exp_id,base,version,grade_value,grade_category,started,ended,response_duration,py_years,prog_years,age,degree,gender,location,code_lines,duration,response_percent,common

pyperf=read.csv(paste0(ESEUR_dir, "developers/1304.5257.csv.xz"), as.is=TRUE)

pyperf$lpy_years=log(pyperf$py_years+0.001)
pyperf$lprog_years=log(pyperf$prog_years+0.001)
pyperf$lcode_lines=log(pyperf$code_lines)

p_mod=lmer(response_duration ~ lprog_years+grade_value
				+version
				+(version | exp_id),
		data=pyperf)


gp_mod=glmer(grade_value ~ lprog_years+lcode_lines+response_duration
				+(response_duration | exp_id),
		data=pyperf, family=poisson)


