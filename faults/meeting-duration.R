#
# meeting-duration.R, 30 Jul 16
#
# Data from:
# Understanding the Sources of Variation in Software Inspection
# Adam Porter and Harvey Siy and Audris Mockus and Lawrence Votta
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

pal_col=rainbow(3)

meeting=read.csv(paste0(ESEUR_dir, "experiment/porter-siy/meeting.csv.xz"), as.is=TRUE)

# Remove one outlier
meeting=meeting[-39, ]


plot(meeting$S_NCSL, meeting$S_MEETDUR,
	col=point_col,
	xlab="Non-comment source lines", ylab="Meeting duration (hours)\n")

lines(loess.smooth(meeting$S_NCSL, meeting$S_MEETDUR, span=0.3), col=loess_col)


gmeet_mod=glm(S_MEETDUR ~ S_NCSL, data=meeting, family=Gamma(link="identity"))

xbounds=1:1000
g_pred=predict(gmeet_mod, newdata=data.frame(S_NCSL=xbounds), se.fit=TRUE)

lines(xbounds, g_pred$fit, col=pal_col[1])
lines(xbounds, g_pred$fit+1.96*g_pred$se.fit, col=pal_col[3])
lines(xbounds, g_pred$fit-1.96*g_pred$se.fit, col=pal_col[3])


nmeet_mod=glm(S_MEETDUR ~ S_NCSL, data=meeting, family=gaussian)

# If points are too close together there is no dash between them.
xbounds=seq(1, 1100, 50)
n_pred=predict(nmeet_mod, newdata=data.frame(S_NCSL=xbounds), se.fit=TRUE)

lines(xbounds, n_pred$fit, col=pal_col[2])
# lines(xbounds, n_pred$fit+1.96*n_pred$se.fit, col=pal_col[3], type="c")
# lines(xbounds, n_pred$fit-1.96*n_pred$se.fit, col=pal_col[3], type="c")

# Robust methods don't change things much
# library("robustbase")
# Robust methods don't change things much
# library("robustbase")
# 
# meet_rob=glmrob(S_MEETDUR ~ S_NCSL, data=meeting, family=Gamma(link="identity"))
# 
# xbounds=1:1000
# pred=predict(meet_rob, newdata=data.frame(S_NCSL=xbounds), type="response", se.fit=TRUE)
# 
# lines(xbounds, pred$fit, col="blue")
# lines(xbounds, pred$fit+1.96*pred$se.fit)
# lines(xbounds, pred$fit-1.96*pred$se.fit)

