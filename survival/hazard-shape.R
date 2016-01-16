#
# hazard-shape.R, 15 Jan 16
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(4)

plot(0, type="n",
	xlim=c(0, 1), ylim=c(0, 1),
	xlab="Time", ylab="h(t)\n")

lines(c(0, 1), c(0.5, 0.5), col=pal_col[1])

x_vals=seq(0, 1, by=0.02)

up_weib=x_vals^1.5
lines(x_vals, up_weib, col=pal_col[2])

down_weib=(0.5+x_vals)^-0.4 -0.7
lines(x_vals, down_weib, col=pal_col[3])

lines(x_vals, x_vals, col=pal_col[4])

legend(x="topleft", legend=c("Exponential", "Weibull", "Weibull", "Rayleigh"),
				bty="n", fill=pal_col, cex=1.3)

