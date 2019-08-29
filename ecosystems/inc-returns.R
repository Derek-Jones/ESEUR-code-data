#
# inc-returns.R, 20 Aug 19
# Data from:
# Example
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG ROI example


source("ESEUR_config.r")


pal_col=rainbow(2)


xrange=c(0, 12.1)
yrange=c(-7.1, 7.1)

plot(-1, type="n", bty="n",
	xaxt="n", yaxt="n",
	xlim=xrange, ylim=yrange,
	xlab="", ylab="Difference in adoptions")

lines(c(0, 0), yrange, col="grey")
lines(xrange, c(0, 0), col="grey")

lines(xrange, c(-4, -4), lwd=0.7, col=pal_col[2])
text(0, -7, "B leads", pos=4, cex=1.3)
lines(xrange, c(5, 5), lwd=0.7, col=pal_col[2])
text(0, 7, "A leads", pos=4, cex=1.3)

text(11, 4, expression(frac(b[S]-a[S], "s")), cex=1.2)
text(11, -3, expression(frac(a[R]-b[R], "r")), cex=1.2)

arrows(5, 6, 5.6, 6.5, length=0.05)
arrows(5, 6+0.5, 5.6, 6.5+0.5, length=0.05)

text(5.6+0.01, 6.5-0.1, "S", pos=4, cex=1.2)
text(5.6+0.01, 6.5+0.5+0.1, "R", pos=4, cex=1.2)

arrows(5, -2, 5.6, -2.5, length=0.05)
arrows(5, -2+0.1, 5.6, -1.5+0.1, length=0.05)

text(5.6+0.01, -1.5, "R", pos=4, cex=1.2)
text(5.6+0.01, -2.5, "S", pos=4, cex=1.2)

arrows(5, -5, 5.6, -5.5, length=0.05)
arrows(5, -5-0.5, 5.6, -5.5-0.5, length=0.05)

text(5.6+0.01, -5.5+0.1, "R", pos=4, cex=1.2)
text(5.6+0.01, -5.5-0.5-0.1, "S", pos=4, cex=1.2)

text(10.5, 0.5, "n", cex=1.2)
text(10.5, -0.5, "total adoptions", cex=1.2)

# Chosen to make the line look 'good'
set.seed(9)

xpoints=seq(0, 6, by=0.1)
walk6=cumsum(c(0, runif(6*10, min=-0.5, max=0.5)))
lines(xpoints, walk6, col=pal_col[1])

# Random walk down to limit line
walk5=cumsum(c(walk6[61], runif(6*10, min=-0.5, max=0.25)))

# Walk is linear, once the limit line is reached
walk5=walk5[walk5 > -4]

lines(6+xpoints, c(walk5, -4-xpoints[1:(61-length(walk5))]), col=pal_col[1])

