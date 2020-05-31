#
# 1-s2_0-S109.R, 26 May 20
# Data from:
# Optimising human community sizes
# Robin I. M. Dunbar and Richard Sosis
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG community_size community_lifespan human_community


source("ESEUR_config.r")


# library("quantreg")

pal_col=rainbow(2)


commun=read.csv(paste0(ESEUR_dir, "ecosystems/1-s2_0-S109.csv.xz"), as.is=TRUE)

commun=subset(commun, !is.na(size))
commun$l_size=log(commun$size)

secular=subset(commun, type == "secular")
religious=subset(commun, type == "religious")

plot(secular$size, secular$duration, log="xy", col=pal_col[1],
	xlim=range(commun$size), ylim=range(commun$duration),
	xlab="Foundation size", ylab="Duration (years)\n")

points(religious$size, religious$duration, col=pal_col[2])

legend(x="right", legend=c("Religious", "Secular"), bty="n", fill=rev(pal_col), cex=1.2)

s_mod=loess.smooth(log(secular$size), log(secular$duration), span=0.3)
lines(exp(s_mod$x), exp(s_mod$y), col=pal_col[1], lty=2)
r_mod=loess.smooth(log(religious$size), log(religious$duration), span=0.3)
lines(exp(r_mod$x), exp(r_mod$y), col=pal_col[2], lty=2)


# Paper plots a quantile regression line, without giving tau.
#
# tau=0.8 (and abouts) is the only value that gets close to anything
# like what appears in the paper.
#
# xbounds=4:max(commun$size)
# 
# rq_mod=rq(log(duration) ~ log(size)+I(log(size)^2), data=secular, tau=0.8)
# 
# pred=predict(rq_mod, newdata=data.frame(size=xbounds))
# 
# lines(xbounds, exp(pred), col=pal_col[1])
# 
# The lines for values of tay > 0.5, that were tried, were convex,
# i.e., not concave like wot appears in the paper.
#
# rq_mod=rq(log(duration) ~ log(size)+I(log(size)^2), data=religious, tau=0.7)
# 
# pred=predict(rq_mod, newdata=data.frame(size=xbounds))
# 
# lines(xbounds, exp(pred), col=pal_col[2])
# 
# Nonparametric regression produces predictions that look vaguely
# like the paper plots.
#
# rq_mod=rqss(log(duration) ~ qss(l_size, lambda=0.5), data=secular, tau=0.8)
# 
# xbounds=5:max(secular$size)
# pred=predict(rq_mod, newdata=data.frame(l_size=log(xbounds)))
#
# lines(xbounds, exp(pred), col=pal_col[1])
# 
#
# rq_mod=rqss(log(duration) ~ qss(l_size, lambda=0.5), data=religious, tau=0.7)
# 
# xbounds=4:max(religious$size)
# pred=predict(rq_mod, newdata=data.frame(l_size=log(xbounds)))
#
# lines(xbounds, exp(pred), col=pal_col[2])
# 

