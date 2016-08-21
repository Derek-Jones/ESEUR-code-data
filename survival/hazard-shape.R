#
# hazard-shape.R,  6 Mar 16
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(3)

plot(0, type="n",
	xlim=c(0, 1), ylim=c(0, 1),
	xlab="Time", ylab="h(t)\n")

# lognormal
t_vals=seq(0.01, 3, by=0.01)
t_sd=1.0
h_lognorm=dnorm(log(t_vals), mean=0.0, sd=t_sd)/
		(t_vals*t_sd*(1-pnorm(log(t_vals), mean=0.0, sd=t_sd)))
lines(t_vals/3, h_lognorm/max(h_lognorm), col=pal_col[1])

# two weibull hazard functions (ignoring the constant multiplier)
x_vals=seq(0, 1, by=0.02)
up_weib=x_vals^5
lines(x_vals, up_weib, col=pal_col[2])

down_weib=(0.6+x_vals)^-0.9 -0.7
lines(x_vals, down_weib, col=pal_col[3])


legend(x="topleft", legend=c("Lognormal", "Weibull", "Weibull"),
				bty="n", fill=pal_col, cex=1.2)

