#
# federal_IT-cost_dur.R, 28 Dec 15
#
# Data from:
# Benchmarking the expected loss of a federal IT portfolio
# P. Kampstra and C. Verhoef
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

brew_col=rainbow(3)


all_fed=read.csv(paste0(ESEUR_dir, "economics/fed.csv.xz"), as.is=TRUE)

fed=subset(all_fed, !is.na(duration.year))
fed$log.IT=log(fed$IT.EUR)

# Gamma explains more of the variance and has lower AIC.
# But we have not got to non-gaussian measurement error yet.
# fed_mod=glm(duration.year ~ log.IT, data=fed, family=Gamma(link="identity"))
fed_mod=glm(duration.year ~ log.IT, data=fed)
summary(fed_mod)

x_bounds=min(fed$IT.EUR):(1+max(fed$IT.EUR))

fed_pred=predict(fed_mod, newdata=data.frame(log.IT=log(x_bounds)), se.fit=TRUE)

plot(fed$IT.EUR, fed$duration.year, log="x", col=point_col,
	xlab="IT budget (million euro)", ylab="Duration (years)")

lines(x_bounds, fed_pred$fit, col=brew_col[1])
lines(x_bounds, fed_pred$fit+1.96*fed_pred$se.fit, col=brew_col[2])
lines(x_bounds, fed_pred$fit-1.96*fed_pred$se.fit, col=brew_col[2])

MSE=sum(fed_mod$residuals^2)/(length(fed_mod$residuals)-2)
pred_se=sqrt(fed_pred$se.fit^2+MSE)
lines(x_bounds, fed_pred$fit+1.96*pred_se, col=brew_col[3])
lines(x_bounds, fed_pred$fit-1.96*pred_se, col=brew_col[3])

# loess_mod=loess(duration.year ~ log.IT, data=fed, span=0.3)
# loess_pred=predict(loess_mod)
# lines(fed$log.IT, loess_pred, col=brew_col[2])


