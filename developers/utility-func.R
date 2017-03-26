#
# utility-func.R, 18 Mar 17
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(3)

x_vals=seq(0, 2.1, by=0.02)

plot(x_vals, x_vals^2, type="l", col=pal_col[1],
	xaxt="n", yaxt="n", xaxs="i", yaxs="i",
	xlab="Wealth", ylab="Utility\n")

axis(1, at=c(1, 2), labels=c("1", "2"))
axis(2, at=c(1, 2^0.5, 2, 4),
		labels=c("1.0", signif(2^0.5, digits=2), "2.0", "4.0"))

lines(c(0, 3), c(0, 3), col=pal_col[2])

lines(x_vals, x_vals^0.5, col=pal_col[3])

lines(c(1, 1), c(0, 1), lty=2)
lines(c(2, 2), c(0, 4), lty=2)
lines(c(0, 1), c(1, 1), lty=2)
lines(c(0, 2), c(2^0.5, 2^0.5), lty=2)
lines(c(0, 2), c(2, 2), lty=2)
lines(c(0, 2), c(2^2, 2^2), lty=2)

