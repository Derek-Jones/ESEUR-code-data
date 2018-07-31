#
# ninio-hermann.R, 13 Jul 18
# Data from:
#
# Example from:
# Evidence-based Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


lean_right=function(x_pos)
{
lines(c(x_pos-0.1, x_pos+0.1+3), y_bounds, col=grey_str, lwd=3.0)
}


lean_left=function(x_pos)
{
lines(c(x_pos+0.1, x_pos-0.1-3), y_bounds, col=grey_str, lwd=3.0)
}


horizontal=function(y_pos)
{
lines(c(0, 8), sqrt(0.02)+(6/6.2)*c(y_pos, y_pos), col=grey_str, lwd=3.0)
}

vertical=function(x_pos)
{
lines(c(x_pos, x_pos), y_bounds, col=grey_str, lwd=3.0)
}


black_dot=function(x_pos, y_pos)
{
points(x_pos+0:3, sqrt(0.02)+(6/6.2)*rep(y_pos, 4), pch=19, cex=1.1, col="white")
points(x_pos+0:3, sqrt(0.02)+(6/6.2)*rep(y_pos, 4), pch=19, cex=0.8)
}


grey_str=grey(0.6)
y_bounds=c(0.9, 7.1)



plot(0, type="n", bty="n",
	xlim=c(2.0, 6.0), ylim=y_bounds,
	xaxt="n", yaxt="n",
	xlab="", ylab="")

# dummy=sapply(-5:10, function(X) lean_right(X))
dummy=sapply(seq(-5, 10, by=0.5), function(X) lean_right(X))
# dummy=sapply(-5:10, function(X) lean_left(X))
dummy=sapply(seq(-5, 10, by=0.5), function(X) lean_left(X))
dummy=sapply(1:8, function(X) horizontal(X))
# dummy=sapply(seq(1, 8, by=0.5), function(X) vertical(X))

black_dot(2.5, 2)
black_dot(2.5, 4)
black_dot(2.5, 6)

