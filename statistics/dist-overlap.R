#
# dist-overlap.R,  2 Dec 15
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=diverge_hcl(2)

y1_sd=1
xpoints=seq(-0.96, 1+2*1.96, by=0.01)
y1_points=dnorm(xpoints, mean=0, sd=y1_sd)
y2_points=dnorm(xpoints, mean=2*y1_sd*1.96, sd=1)

plot(xpoints, y1_points, type="l", col=pal_col[2], bty="n",
	xaxt="n", yaxt="n",
	xlab="", ylab="",
	xlim=range(xpoints), ylim=c(0, 0.5))
text(0, 0.2, "A", cex=2, col=pal_col[2])

lines(xpoints, y2_points, col=pal_col[1])
text(2*y1_sd*1.96, 0.2, "B", cex=2, col=pal_col[1])

upper_y=subset(y2_points, xpoints <= 1.96)
upper_x=subset(xpoints, xpoints <= 1.96)

polygon(c(upper_x, 1.96, 0), c(upper_y, 0, 0), col="red")


