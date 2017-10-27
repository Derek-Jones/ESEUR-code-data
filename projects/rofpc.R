#
# rofpc.R, 17 Oct 17
# Data from:
# Reliability of function point counts
# P. Kampstra and C. Verhoef
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


rofpc=read.csv(paste0(ESEUR_dir, "projects/rofpc.csv.xz"), as.is=TRUE)
# We know one set of extracte dvalues must be integer
rofpc$Function.points=as.integer(0.1+rofpc$Function.points)

plot(rofpc$Function.points, rofpc$Cost.index, log="xy", col=point_col,
	xlab="Function points", ylab="Cost\n")

# Quadratic is a slightly better fit, but predicts eventual decline of costs
# with increasing function-points.
# Not tried outlier removal.
# rof_mod=glm(Cost.index ~ log(Function.points)+I(log(Function.points)^2), data=rofpc, family=gaussian(link="log"))

# Assume error is multiplicative, rather than additive, so log link
rof_mod=glm(log(Cost.index) ~ log(Function.points), data=rofpc)

xbounds=20:2000

pred=predict(rof_mod, newdata=data.frame(Function.points=xbounds), type="response")

lines(xbounds, exp(pred), col=point_col)

# Cost has been normalised, should use beta distribution.
# But the fit is almost identical...
#
# library("betareg")
#
# b_mod=betareg(Cost.index ~ log(Function.points), data=rofpc, link="log")
# summary(b_mod)
# pred=predict(b_mod, newdata=data.frame(Function.points=xbounds), type="response")
# lines(xbounds, pred, col="red")

