#
# federal_IT.R, 17 Dec 14
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

t=order(fed$log.IT)
fed=fed[t, ]

log.IT_sqr=log(fed$IT.EUR)^2

fed_n_mod=glm(duration.year ~ log.IT, data=fed)
summary(fed_n_mod)

fed_n_pred=predict(fed_n_mod, newdata=list(log.IT=1:7, log.IT_sqr=(1:7)^2), type="response", se.fit=TRUE)

plot(fed$log.IT, fed$duration.year,
	xlab="IT budget", ylab="Duration (years)")

lines(fed_n_pred$fit, col=brew_col[1])
lines(fed_n_pred$fit+1.96*fed_n_pred$se.fit, col=brew_col[3])
lines(fed_n_pred$fit-1.96*fed_n_pred$se.fit, col=brew_col[3])

loess_mod=loess(duration.year ~ log.IT, data=fed, span=0.3)
loess_pred=predict(loess_mod)
lines(fed$log.IT, loess_pred, col=brew_col[2])


fed_b_mod=glm(duration.year ~ log.IT-1, data=fed)
summary(fed_b_mod)

fed_2_mod=glm(duration.year ~ log.IT+log.IT_sqr-1, data=fed)
summary(fed_2_mod)


