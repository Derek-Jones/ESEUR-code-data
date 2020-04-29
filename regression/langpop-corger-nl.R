#
# langpop-corger-nl.R, 24 Mar 20
#
# Data from:
# http://langpop.corger.nl/results
# Recording data from February 2013, downloaded 12 July 2014
# by Gerben Kunst
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Stackoverflow_languages Github_languages


source("ESEUR_config.r")

plot_layout(2, 1, max_height=13, default_width=6)
par(mar=MAR_default+c(-0.5, 0.8, -0.5, -0.5))

pal_col=rainbow(3)

langpop=read.csv(paste0(ESEUR_dir, "regression/langpop-corger-nl.csv.xz"), as.is=TRUE)
langpop=subset(langpop, github > 0 & stackoverflow > 0)
langpop$log_github=log(langpop$github)

plot(langpop$github, langpop$stackoverflow, log="xy", col=pal_col[2],
	yaxs="i",
	xlab="Github: lines checked in", ylab="Stackoverflow: language tags\n\n")

plot(langpop$github, langpop$stackoverflow, log="xy", col=pal_col[2],
	yaxs="i",
	xlab="Github: lines checked in", ylab="Stackoverflow: language tags\n\n")

loess_mod=loess(log(stackoverflow) ~ log_github, data=langpop, span=0.3)
x_points=1:max(langpop$log_github)
loess_pred=predict(loess_mod, newdata=data.frame(log_github=x_points))
lines(exp(x_points), exp(loess_pred), col=pal_col[1])

# lines(loess.smooth(langpop$github, langpop$stackoverflow, span=0.3), col=loess_col)

lang_mod=glm(log(stackoverflow) ~ log_github+I(log_github^2), data=langpop)

x_points=1:max(langpop$log_github)
pred=predict(lang_mod, newdata=data.frame(log_github=x_points), type="response", se.fit=TRUE)

lines(exp(x_points), exp(pred$fit), col=pal_col[3])
# lines(exp(x_points), exp(pred$fit+1.96*pred$se.fit))
# lines(exp(x_points), exp(pred$fit-1.96*pred$se.fit))

# lang_mod=glm(log(stackoverflow) ~ log_github, data=langpop)
# pred=predict(lang_mod, newdata=data.frame(log_github=x_points), type="response", se.fit=TRUE)
# 
# lines(exp(x_points), exp(pred$fit), col="black")

