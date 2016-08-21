#
# langpop-corger-nl.R, 20 Aug 16
#
# Data from:
# http://langpop.corger.nl/results
# Recording data from February 2013, downloaded 12 July 2014
# by Gerben Kunst
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

plot_layout(2, 1)

langpop=read.csv(paste0(ESEUR_dir, "regression/langpop-corger-nl.csv.xz"), as.is=TRUE)
langpop=subset(langpop, github > 0 & stackoverflow > 0)
langpop$log_github=log(langpop$github)

pal_col=rainbow(2)

plot(langpop$github, langpop$stackoverflow, log="xy", col=point_col,
	xlab="", ylab="Stackoverflow: language tags\n")

plot(langpop$github, langpop$stackoverflow, log="xy", col=point_col,
	xlab="Github: lines checked in", ylab="Stackoverflow: language tags\n")

loess_mod=loess(log(stackoverflow) ~ log_github, data=langpop, span=0.3)
x_points=1:max(langpop$log_github)
loess_pred=predict(loess_mod, newdata=data.frame(log_github=x_points))
lines(exp(x_points), exp(loess_pred), col=pal_col[1])

# lines(loess.smooth(langpop$github, langpop$stackoverflow, span=0.3), col=loess_col)

lang_mod=glm(log(stackoverflow) ~ log_github+I(log_github^2), data=langpop)

x_points=1:max(langpop$log_github)
pred=predict(lang_mod, newdata=data.frame(log_github=x_points), type="response", se.fit=TRUE)

lines(exp(x_points), exp(pred$fit), col=pal_col[2])
# lines(exp(x_points), exp(pred$fit+1.96*pred$se.fit))
# lines(exp(x_points), exp(pred$fit-1.96*pred$se.fit))

# lang_mod=glm(log(stackoverflow) ~ log_github, data=langpop)
# pred=predict(lang_mod, newdata=data.frame(log_github=x_points), type="response", se.fit=TRUE)
# 
# lines(exp(x_points), exp(pred$fit), col="black")

