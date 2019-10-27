#
# rofpc.R, 29 Sep 19
# Data from:
# Reliability of function point counts
# P. Kampstra and C. Verhoef
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG function-points project_cost


source("ESEUR_config.r")


pal_col=rainbow(2)


rofpc=read.csv(paste0(ESEUR_dir, "projects/rofpc.csv.xz"), as.is=TRUE)
# We know one set of extracted values must be integer
rofpc$Function.points=as.integer(0.1+rofpc$Function.points)

plot(rofpc$Function.points, rofpc$Cost.index, log="xy", col=pal_col[2],
	xlab="Function points", ylab="Cost\n")

# Quadratic is a slightly better fit, but predicts eventual decline of costs
# with increasing function-points.
# Not tried outlier removal.
# rof_mod=glm(Cost.index ~ log(Function.points)+I(log(Function.points)^2), data=rofpc, family=gaussian(link="log"))

# Assume error is multiplicative, rather than additive, so log link
rof_mod=glm(log(Cost.index) ~ log(Function.points), data=rofpc)

xbounds=20:2000

pred=predict(rof_mod, newdata=data.frame(Function.points=xbounds), type="response")

lines(xbounds, exp(pred), col=pal_col[1])

# Cost has been normalised, should use beta distribution.
# But the fit is almost identical...
#
# library("betareg")
#
# b_mod=betareg(Cost.index ~ log(Function.points), data=rofpc, link="log")
# summary(b_mod)
# pred=predict(b_mod, newdata=data.frame(Function.points=xbounds), type="response")
# lines(xbounds, pred, col="red")

