#
# normal-sd.R, 14 Apr 20
# Data from:
# Example
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example

source("ESEUR_config.r")


par(mar=MAR_default-c(0.0, 3.2, 0, 0.7))


pal_col=rainbow(2)

plot(dnorm, col=pal_col[1],
	xaxt="n", yaxt="n", bty="n",
	xlim=c(-4.5, 5.1),
	xlab="", ylab="")
axis(1, at=c(0, 0, 0+1, 0-1, 0+2, 0-2, 0+3, 0-3, 0+4, 0-4),
	lab= expression(NA, mu, sigma, -sigma, 2*sigma, -2*sigma, NA, NA, 4*sigma, -4*sigma),
	col="grey",
	pos=-0.001, cex.axis=1.2)

sd_percent=function(x)
{
sd_x=dnorm(x)

lines(c(-x, x), c(sd_x, sd_x), col=pal_col[2])

text(0.0, sd_x-0.009, paste0(round(100*(2*pnorm(x)-1), 1), "%"), pos=3)
options(scipen=7)
text(x+0.05, sd_x, paste0("p=", round(1-pnorm(x), 4)), pos=4)
text(-x-0.05, sd_x+0.004, as.expression(substitute(s ~ sigma, list(s=round(x, 2)))), pos=2)
}

sd_percent(1)
sd_percent(qnorm(1-(1-0.90)/2))
sd_percent(qnorm(1-(1-0.95)/2))
sd_percent(qnorm(1-(1-0.99)/2))
sd_percent(qnorm(1-(1-0.999)/2))

# Show interquartile range across the top???

