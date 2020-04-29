#
# moores-fab.R, 14 Apr 20
# Data from:
# Example
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Moores-law


source("ESEUR_config.r")


plot_layout(1, 1, default_height=0.48*ESEUR_default_height)
par(mar=MAR_default-c(3.1, 2.7, 0.8, 0.8))

pal_col=rainbow(3)

x_vals=seq(0, 1, by=0.001)
y=sqrt(1-x_vals^2)

plot(0, type="n", bty="n",
	xaxs="i", xaxs="i",
	xaxt="n", yaxt="n",
	xlim=c(-1, 3.22), ylim=c(-1, 1.0),
	xlab="", ylab="")

x_line=seq(-1, 1, by=0.3)

polygon(c(x_vals, rev(x_vals), -x_vals, -rev(x_vals)),
	c(y, -rev(y), -y, rev(y)), col="yellow")


polygon(0.3*c(1, 5, 5, 6, 6, 5, 5, 2, 2, 1, 1)-1,
	0.3*c(1, 1, 2, 2, 5, 5, 6, 6, 5, 5, 1)-1,
	col="blue")
points(0, 0.1, col="red", pch=19, cex=0.7)

t=sapply(x_line, function(X) lines(c(X, X), c(-1, 1), col="grey"))
t=sapply(x_line, function(X) lines(c(-1, 1), c(X, X), col="grey"))


base=2.2
x_line=seq(-1, 1, by=0.4)

polygon(base+c(x_vals, rev(x_vals), -x_vals, -rev(x_vals)),
	c(y, -rev(y), -y, rev(y)), col="yellow")


polygon(base+0.4*c(0, 1, 1, 2, 2, 3, 3, 4, 4, 1, 1, 0, 0)-1+0.1,
	0.4*c(2, 2, 1, 1, 0, 0, 1, 1, 4, 4, 3, 3, 2)-1+0.1,
	col="blue")
points(base+0, 0.1, col="red", pch=19, cex=0.7)

t=sapply(x_line, function(X) lines(base+0.1+c(X, X), c(-1, 1), col="grey"))
t=sapply(x_line, function(X) lines(base+c(-1, 1), 0.1+c(X, X), col="grey"))


