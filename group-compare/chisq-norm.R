#
# chisq-norm.R,  2 Dec 15
#
# Data from:
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example


source("ESEUR_config.r")


pal_col=rainbow(3)

the_mean=4

x_axis=seq(0, 8, 0.1)
plot(x_axis, dchisq(x_axis, df=the_mean), type="l", col=pal_col[1],
	yaxt="n", ylim=c(0, 0.2),
	xlab="", ylab="")

chi_median=the_mean-(1-2/(9*the_mean))^3
lines(c(chi_median, chi_median), c(0.15, 0.17), col=pal_col[2])

lines(c(4, 4), c(0.12, 0.15), col=pal_col[2])

lines(x_axis, dnorm(x_axis, mean=the_mean, sd=(2*the_mean)^0.5), col=pal_col[3])

