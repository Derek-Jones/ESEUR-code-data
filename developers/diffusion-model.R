#
# diffusion-model.R,  6 Dec 19
# Data from:
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example psychology decision

source("ESEUR_config.r")


pal_col=rainbow(2)


diffus_line=function(seed, col_str)
{
set.seed(seed)
x_points=seq(0, 2, by=0.01)
y_points=1+x_points/2+0.15*rnorm(length(x_points))
thresh=which(y_points > 2)

lines(x_points[1:thresh[1]], y_points[1:thresh[1]], col=col_str)

text(x_points[thresh[1]-1]+0.01, 2, labels="X", col="green")
}


plot(0, type="n", bty="n",
	xaxs="i", yaxs="i",
	xaxt="n", yaxt="n",
	xlim=c(0, 2), ylim=c(0, 2),
	xlab="", ylab="Evidence accumulated")
axis(2, at=1, label=0)

lines(c(0, 0), c(0, 2))
lines(c(0, 2), c(0, 0), col=pal_col[2])
arrows(0, 1, 1.7, 1, 0.1, col="grey")
lines(c(0, 2), c(2, 2), col=pal_col[2])

text(1.85, 1.0, "Time", cex=1.5)
text(0.1, 1.9, "A", cex=2)
text(0.1, 0.1, "B", cex=2)


diffus_line(3312, pal_col[1])
# diffus_line(4, pal_col[2])


