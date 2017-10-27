#
# Avidan-MSc.R, 25 Sep 17
# Data from:
# The Significance of Method Parameters and Local Variables as Beacons for Comprehension: An Empirical Study
# Eran Avidan
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("lme4")


idxx=read.csv(paste0(ESEUR_dir, "src_measure/Avidan-MSc.csv.xz"), as.is=TRUE)

idxx$response=60*as.integer(substr(idxx$time.to.answer, 1, 2))+
			as.integer(substr(idxx$time.to.answer, 4, 5))

# Not allowed to have a column called function, a "." gets added
idxx$func=idxx$function.

id_mod=glm(response ~ func+treatment, data=idxx)
summary(id_mod)

id_lme=lmer(response ~ func+treatment+(treatment | subject), data=idxx)
summary(id_lme)


