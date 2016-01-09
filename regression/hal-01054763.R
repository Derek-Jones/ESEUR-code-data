#
# hal-01054763.R,  3 Dec 15
#
# Data from:
#
# Collective mind: {Towards} practical and collaborative auto-tuning
# Grigori Fursin and Renato Miceli and Anton Lokhmotov and Michael Gerndt and Marc Baboulin and Allen D. Malony and Zbigniew Chamski and Diego Novillo and Davide Del Vento
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("reshape2")


pal_col=rainbow(2)

gcc_opts=read.csv(paste0(ESEUR_dir, "regression/hal-01054763_flags.csv.xz"), as.is=TRUE)

gcc_12=subset(gcc_opts, year < 2012)

plot(gcc_12$year, gcc_12$opt_flags, col=pal_col[1],
	ylim=c(2, max(gcc_12$opt_flags)),
	xlab="Year", ylab="Total")
points(gcc_12$year, gcc_12$parameters, col=pal_col[2])

gcc_all_opts=melt(gcc_12, id.vars=c("gcc_version", "year"))

opt_mod=glm(value ~ year+variable, data=gcc_all_opts)
pred_vals=predict(opt_mod)

opt_pred=pred_vals[gcc_all_opts$variable == "opt_flags"]
lines(gcc_12$year, opt_pred)
 
param_pred=pred_vals[gcc_all_opts$variable != "opt_flags"]
lines(gcc_12$year, param_pred)
 
 
