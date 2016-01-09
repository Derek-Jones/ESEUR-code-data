#
# normal-sd.R, 11 Dec 15
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

plot(dnorm, col="grey",
	xaxt="n", yaxt="n", bty="n",
	xlim=c(-4.1, 4.1),
	xlab="", ylab="")
axis(1, at=c(0, 0, 0+1, 0-1, 0+2, 0-2, 0+4, 0-4),
	lab= expression(NA, mu, sigma, -sigma, NA, NA, NA, NA),
	col="grey",
	pos=-0.001, cex.axis=1.2)

sd_percent=function(x)
{
sd_x=dnorm(x)

lines(c(-x, x), c(sd_x, sd_x), col="yellow")

text(0.0, sd_x-0.009, paste0(round(100*(2*pnorm(x)-1), 1), "%"), pos=3)
text(x+0.05, sd_x, paste0("p=", round(1-pnorm(x), 2)), pos=4)
text(-x-0.05, sd_x+0.004, as.expression(substitute(s ~ sigma, list(s=round(x, 2)))), pos=2)
}

sd_percent(1)
sd_percent(qnorm(1-(1-0.90)/2))
sd_percent(qnorm(1-(1-0.95)/2))
sd_percent(qnorm(1-(1-0.99)/2))
sd_percent(qnorm(1-(1-0.999)/2))

# Show interquartile range across the top???

