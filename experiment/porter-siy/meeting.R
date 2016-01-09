#
# meeting.R, 23 Dec 15
#
# Data from:
# Understanding the Sources of Variation in Software Inspection
# Adam Porter and Harvey Siy and Audris Mockus and Lawrence Votta
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("MASS")


meeting=read.csv(paste0(ESEUR_dir, "experiment/porter-siy/meeting.csv.xz"), as.is=TRUE)

meeting$sessions=as.numeric(substr(meeting$TREAT, 1, 1))
meeting$persons=as.numeric(substr(meeting$TREAT, 4, 4))
meeting$repair=substr(meeting$TREAT, 6, 6)

# Remove one outlier
meeting=meeting[-39, ]

brew_col=rainbow_hcl(3)

sess_1=subset(meeting, persons==1)
sess_2=subset(meeting, persons==2)

plot(sess_1$S_MEETDUR, sess_1$S_MEETGAIN, col="red")
points(sess_2$S_MEETDUR, sess_2$S_MEETGAIN, col="green")

lines(loess.smooth(sess_1$S_MEETDUR, sess_1$S_MEETGAIN, span=0.3, family="gaussian"), col="red")
lines(loess.smooth(sess_2$S_MEETDUR, sess_2$S_MEETGAIN, span=0.3, family="gaussian"), col="green")

# Something simple
# pmeet_mod=glm(S_MEETGAIN ~ log(S_MEETDUR), data=meeting, family=poisson)
pmeet_mod=glm(S_MEETGAIN ~ S_MEETDUR, data=meeting, family=quasipoisson(link="identity"),
		start=c(1,1))

xbounds=seq(0, 3, 0.2)
pred=predict(pmeet_mod, newdata=data.frame(S_MEETDUR=xbounds), type="response", se.fit=TRUE)

lines(xbounds, pred$fit, col="red")
lines(xbounds, pred$fit+1.96*pred$se.fit)
lines(xbounds, pred$fit-1.96*pred$se.fit)


plot(meeting$S_NCSL, meeting$S_MEETGAIN)

pairs(~S_TRUEDEF + log(S_NCSL)+log(S_MEETDUR), data=meeting)

# Something more complicated
meet_mod=glm(S_TRUEDEF ~ (S_NCSL+S_MEETDUR+persons+sessions+repair)^2, data=meeting,
			family=quasipoisson(link="identity"),
			start=rep(1, 21))
t=stepAIC(meet_mod)

# and the 'best' model could be...
meet_mod=glm(S_TRUEDEF ~ S_NCSL+S_MEETDUR+persons:repair, data=meeting,
			family=quasipoisson(link="identity"),
			start=rep(1, 6))
summary(meet_mod)


# meet_mod=glm(S_MEETDUR ~ S_NCSL, data=meeting)
# abline(meet_mod)

pmeet_mod=glm(S_MEETDUR ~ S_NCSL, data=meeting, family=Gamma(link="identity"))

xbounds=1:1000
pred=predict(pmeet_mod, newdata=data.frame(S_NCSL=xbounds), type="response", se.fit=TRUE)

lines(xbounds, pred$fit, col="red")
lines(xbounds, pred$fit+1.96*pred$se.fit)
lines(xbounds, pred$fit-1.96*pred$se.fit)


# Robust methods don't change things much
# library("robustbase")

# meet_rob=glmrob(S_MEETGAIN ~ S_MEETDUR, data=meeting, family=poisson)
# xbounds=seq(0, 3, 0.2)
# pred=predict(meet_rob, newdata=data.frame(S_MEETDUR=xbounds), type="response", se.fit=TRUE)
# 
# lines(xbounds, pred$fit, col="blue")
# lines(xbounds, pred$fit+1.96*pred$se.fit)
# lines(xbounds, pred$fit-1.96*pred$se.fit)
# 
# meet_rob=glmrob(S_MEETDUR ~ S_NCSL, data=meeting, family=Gamma(link="identity"))
# 
# xbounds=1:1000
# pred=predict(meet_rob, newdata=data.frame(S_NCSL=xbounds), type="response", se.fit=TRUE)
# 
# lines(xbounds, pred$fit, col="blue")
# lines(xbounds, pred$fit+1.96*pred$se.fit)
# lines(xbounds, pred$fit-1.96*pred$se.fit)
# 
# meet_rob=glmrob(S_MEETGAIN ~ S_NCSL, data=meeting, family=poisson)
# 
# xbounds=1:1000
# pred=predict(meet_rob, newdata=data.frame(S_NCSL=xbounds), type="response", se.fit=TRUE)
# 
# lines(xbounds, pred$fit, col="blue")
# lines(xbounds, pred$fit+1.96*pred$se.fit)
# lines(xbounds, pred$fit-1.96*pred$se.fit)
# 

