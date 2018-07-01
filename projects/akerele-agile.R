#
# akerele-agile.R, 29 Apr 18
# Data from:
# Evaluating the Impact of Critical Factors in Agile Continuous Delivery Process: A System Dynamics Approach
# Olumide Akerele and Muthu Ramachandran and Mark Dixon
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# TAG agile, user-stories projects development


source("ESEUR_config.r")


proj=read.csv(paste0(ESEUR_dir, "projects/akerele-agile.csv.xz"), as.is=TRUE)

proj=subset(proj, LOC != 0)

plot(proj$user_stories, proj$LOC, col=point_col,
	xlab="User stories", ylab="LOC\n")

p_mod=glm(LOC ~ I(user_stories^0.5), data=proj)

# The following is a slightly better fit, same AIC, but not as interesting.
# p_mod=glm(LOC ~ user_stories+I(user_stories^2), data=proj)
summary(p_mod)


plot(proj$user_stories, proj$tasks_act, col=point_col,
	xlab="Tasks", ylab="LOC\n")

# p_mod=glm(LOC ~ I(tasks_act^0.5), data=proj)

p_mod=glm(LOC ~ tasks_act, data=proj)
summary(p_mod)


