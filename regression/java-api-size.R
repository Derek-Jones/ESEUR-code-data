#
# java-api-size.R, 18 Sep 18
#
# Data from:
# A large-scale analysis of Java API usage
# Jurgen Starek
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Java API LOC


source("ESEUR_config.r")


library("gamlss")
library("gamlss.tr")


pal_col=rainbow(4)

API=read.csv(paste0(ESEUR_dir, "regression/APINumberToProjectSizeScannerBased.csv.xz"), as.is=TRUE)

API=subset(API, Size > 0)
API$l_size=log(API$Size)

plot(API$Size, API$APIs, log="x", col=point_col,
	xlab="Lines of code", ylab="APIs")

t=loess.smooth(API$l_size, API$APIs, span=0.3)
lines(exp(t$x), t$y, col=loess_col)

# ap_mod=glm(APIs ~ l_size, data=API, family=poisson)
# 
# pred=predict(ap_mod, newdata=data.frame(l_size=1:20), type="link", se.fit=TRUE)
# lines(exp(1:20), pred$fit, col=pal_col[1])

# zero-truncate
gen.trun(par=0, family=PO(mu.link=identity))

tr_mod=gamlss(APIs ~ l_size+I(l_size^2.2), data=API, family=POtr)
# summary(tr_mod)

pred=predict(tr_mod, newdata=data.frame(l_size=1:20), se.fit=TRUE)

lines(exp(1:20), pred, col=pal_col[1])

# se.fit = TRUE is not supported for new data values at the moment 
# lines(exp(1:20), pred$fit+1.96*pred$se.fit, col=pal_col[2])
# lines(exp(1:20), pred$fit-1.96*pred$se.fit, col=pal_col[2])

# A start argument is needed when link="identity" and the data contains zeros
# api_mod=glm(APIs ~ l_size+I(l_size^2), data=API, family=poisson(link="identity"),
# 		start=c(1, 1, 1))

ap_id_mod=glm(APIs ~ l_size+I(l_size^2.0), data=API, family=poisson(link="identity"),
		start=c(1, 1, 1))
# summary(ap_id_mod)

pred=predict(ap_id_mod, newdata=data.frame(l_size=1:20), type="link", se.fit=TRUE)

lines(exp(1:20), pred$fit, col=pal_col[3])
lines(exp(1:20), pred$fit+1.96*pred$se.fit, col=pal_col[2])
lines(exp(1:20), pred$fit-1.96*pred$se.fit, col=pal_col[2])

ag_mod=glm(APIs ~ l_size+I(l_size^2.0), data=API)
# summary(ag_mod)

pred=predict(ag_mod, newdata=data.frame(l_size=1:20), type="link", se.fit=TRUE)

lines(exp(1:20), pred$fit, col=pal_col[4])
lines(exp(1:20), pred$fit+1.96*pred$se.fit, col=pal_col[2])
lines(exp(1:20), pred$fit-1.96*pred$se.fit, col=pal_col[2])

