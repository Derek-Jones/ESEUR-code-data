#
# patmain_tse2001.R, 20 Dec 17
# Data from:
# A Controlled Experiment in Maintenance Comparing Design Patterns to Simpler Solutions
Lutz Prechelt and Barbara Unger and Walter F. Tichy and Peter Bossler and Lawrence G. Votta
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("lme4")


pm=read.csv(paste0(ESEUR_dir, "maintenance/patmain_tse2001.csv"), as.is=TRUE)

pm$is_post=(pm$seq_num > 2)


pm_mod=glm(time ~ (group+type+abc)^2
			-type:abc
			+type:seq
			+task+task:group
			+is_post,
			data=pm)
summary(pm_mod)


pm_mod=lmer(time ~ (group+type+abc)^2
			-type:abc
			+type:seq
			+task+task:group
			+is_post
			+(task | id),
			data=pm)
summary(pm_mod)


