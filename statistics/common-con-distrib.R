#
# common-con-distrib.R, 30 Dec 15
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

plot_layout(2, 2)

brew_col=rainbow(3)

plot(c(0, 1, 1, 4, 4, 5), c(0, 0, 0.25, 0.25, 0, 0), type="l",
	bty="n", yaxt="n",
	col=brew_col[1],
	xlab="x", ylab="")

x_exp=seq(0, 2, by=0.1)
plot(x_exp, dexp(x_exp, rate=1), type="l",
	bty="n", yaxt="n",
	col=brew_col[1],
	xlim=range(x_exp), ylim=c(0, 4),
	xlab="x", ylab="")
lines(x_exp, dexp(x_exp, rate=2), col=brew_col[2])
lines(x_exp, dexp(x_exp, rate=4), col=brew_col[3])
legend(x="topright", legend=c("rate=1", "rate=2", "rate=4"), bty="n", fill=brew_col, cex=1.3)

sigma_str=function(num) as.expression(substitute(sigma == num))

x_norm=seq(-8, 8, by=0.1)
plot(x_norm, dnorm(x_norm, sd=1), type="l",
	bty="n", yaxt="n",
	col=brew_col[1],
	xlim=range(x_norm), ylim=c(0, 0.4),
	xlab="x", ylab="")
lines(x_norm, dnorm(x_norm, sd=2), col=brew_col[2])
lines(x_norm, dnorm(x_norm, sd=4), col=brew_col[3])
legend(x="topright", legend=c(sigma_str(1), sigma_str(2), sigma_str(4)),
		 bty="n", fill=brew_col, cex=1.3)


x_beta=seq(0, 1, by=0.01)
plot(x_beta, dbeta(x_beta, shape1=0.5, shape2=0.5), type="l",
	bty="n", yaxt="n",
	col=brew_col[1],
	xlim=range(x_beta), ylim=c(0, 2.5),
	xlab="x", ylab="")
lines(x_beta, dbeta(x_beta, shape1=2, shape2=2), col=brew_col[2])
lines(x_beta, dbeta(x_beta, shape1=2, shape2=5), col=brew_col[3])
legend(x="topright", legend=c("shape1=0.5\nshape2=0.5\n", "shape1=2\nshape2=2\n", "shape1=2\nshape2=5"), bty="n", fill=brew_col, cex=1.3)

