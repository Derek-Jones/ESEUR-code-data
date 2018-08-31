#
# XP_timing.R, 22 Aug 18
# Data from:
# Allan Kelly
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones

source("ESEUR_config.r")


library("lme4")


pal_col=rainbow(7)


XP=read.csv(paste0(ESEUR_dir, "projects/XP_timing.csv.xz"), as.is=TRUE)

XP$just_plan=XP$Planned-XP$Estimates

plot(XP$Team.Size, XP$Planned)
lines(loess.smooth(XP$Team.Size, XP$Planned, span=0.5), col=loess_col)

plot(XP$Team.Size, XP$just_plan)
lines(loess.smooth(XP$Team.Size, XP$just_plan, span=0.5), col=loess_col)

plot(XP$Estimates, XP$Planned, col=pal_col[XP$Team.Size])
lines(loess.smooth(XP$Estimates, XP$Planned, span=0.5), col=loess_col)

plot(XP$Estimates, XP$just_plan, col=pal_col[XP$Team.Size])
lines(loess.smooth(XP$Estimates, XP$just_plan, span=0.5), col=loess_col)

# xp_mod=glm(Estimates ~ Date:(Team.Size+I(Team.Size^2)), data=XP)

# xp_mod=nls(Planned ~ a+b*Team.Size^e+c*Estimates^d, trace=TRUE,
# 		start=list(a=-4.2, b=0.83, c=5.3, d=0.5, e=1.0), data=XP)

# xp_mod=glm(Planned ~ Date+Team.Size+I(Estimates^0.5), data=XP)
xp_mod=glm(Planned ~ Team.Size+I(Estimates^0.5), data=XP)
summary(xp_mod)

XP$sqrt_E=sqrt(XP$Estimates)

xp_re_mod=lmer(Planned ~ Team.Size+sqrt_E+(Team.Size | Date), data=XP)
xp_re_mod=lmer(Planned ~ Team.Size+sqrt_E+(sqrt_E | Date), data=XP)

# The following has the smallest AIC, but by an insignificant amount
xp_re_mod=lmer(Planned ~ Team.Size+sqrt_E+(1 | Date), data=XP)
summary(xp_re_mod)


xbounds=1:7
pred=predict(xp_mod, newdata=data.frame(Team.Size=xbounds))
lines(xbounds, pred, col="green")

# xp_mod=glm(just_plan ~ I(Team.Size^0.5), data=XP)
# summary(xp_mod)

# xp_mod=nls(just_plan ~ a+b*Team.Size^c, trace=TRUE,
# 		start=list(a=3.2, b=0.8, c=0.5), data=XP)


