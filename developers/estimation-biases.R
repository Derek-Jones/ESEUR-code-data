#
# estimation-biases.R, 30 Sep 15
#
# Data from (kindly supplied by Jorgensen):
#
# Software Development Estimation Biases: {The} Role of Interdependence
# Magne J{\o}rgensen and Stein Grimstad
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human estimate_bias estimate_country estimate_gender LOC estimate_anchoring


source("ESEUR_config.r")


library("car")


dev_est=read.csv(paste0(ESEUR_dir, "developers/SendAway2013.csv.xz"), as.is=TRUE)

# est_mod=glm(LOC.Prod ~ (Country+Gender+Role+LOC.Group)^3,
# 				data=dev_est)
# est_mod=glm(LOC.Prod ~ LOC.Group:Gender+LOC.Group,
est_mod=glm(LOC.Prod ~ Country:Gender+LOC.Group,
				data=dev_est)
Anova(est_mod)

# Value of interest is LOC.Group
summary(est_mod)


# est_mod=glm(Ticket.estimate ~ (Country+Gender+Role+LOC.Group+Ticket.group)^3,
# 				data=dev_est)
est_mod=glm(Ticket.estimate ~ Gender:(Country+Role)^2,
				data=dev_est)
Anova(est_mod)
summary(est_mod)


