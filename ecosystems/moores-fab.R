#
# moores-fab.R, 21 Nov 17
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(1, 1, default_width=ESEUR_default_height,
		  default_height=1.8*ESEUR_default_height)


pal_col=rainbow(3)

x_vals=seq(0, 1, by=0.001)
y=sqrt(1-x_vals^2)

plot(0, type="n", bty="n",
	xaxt="n", yaxt="n",
	xlim=c(-1, 1), ylim=c(-1, 3.1),
	xlab="", ylab="")

x_line=seq(-1, 1, by=0.3)

polygon(c(x_vals, rev(x_vals), -x_vals, -rev(x_vals)),
	c(y, -rev(y), -y, rev(y)), col="yellow")


polygon(0.3*c(1, 5, 5, 6, 6, 5, 5, 2, 2, 1, 1)-1,
	0.3*c(1, 1, 2, 2, 5, 5, 6, 6, 5, 5, 1)-1,
	col="blue")
points(0, 0.1, col="red", pch=19, cex=1.3)

t=sapply(x_line, function(X) lines(c(X, X), c(-1, 1), col="grey"))
t=sapply(x_line, function(X) lines(c(-1, 1), c(X, X), col="grey"))


base=2.2
x_line=seq(-1, 1, by=0.4)

polygon(c(x_vals, rev(x_vals), -x_vals, -rev(x_vals)),
	base+c(y, -rev(y), -y, rev(y)), col="yellow")


polygon(0.4*c(0, 1, 1, 2, 2, 3, 3, 4, 4, 1, 1, 0, 0)-1+0.1,
	base+0.4*c(2, 2, 1, 1, 0, 0, 1, 1, 4, 4, 3, 3, 2)-1+0.1,
	col="blue")
points(0, base+0.1, col="red", pch=19, cex=1.3)

t=sapply(x_line, function(X) lines(0.1+c(X, X), base+c(-1, 1), col="grey"))
t=sapply(x_line, function(X) lines(c(-1, 1), base+0.1+c(X, X), col="grey"))



