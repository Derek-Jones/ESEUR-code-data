#
# shorter-iden.R, 23 Jun 18
# Data from:
# Shorter Identifier Names Take Longer to Comprehend
# Johannes Hofmeister and Janet Siegmund and Daniel V. Holt
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# TAG identifier experiment


source("ESEUR_config.r")


library("lme4")


sid=read.csv(paste0(ESEUR_dir, "sourcecode/shorter-iden.csv.xz"), as.is=TRUE, sep=";")

plot(~ first_impression_s+trial+task_order+as.factor(snippet)+as.factor(task)+as.factor(condition),
                         data=sid)

# The AIC without an exponential is only slightly less good, but the
# standard error is worse.  Should we go for with the power law of learning?
# sid_mod=lmer(first_impression_s ~ exp(-trial)+snippet+task+condition+
sid_mod=lmer(first_impression_s ~ trial+snippet+task+condition+
							(1 | participant),
# The slightly better model, with 100% correlation!
#							(task | participant),
			data=sid)
summary(sid_mod)
AIC(sid_mod)

