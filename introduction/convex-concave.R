#
# convex-concave.R,  2 Apr 18
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(2, 1)

pal_col=rainbow(2)


cave_y=function(x)
{
return((5-x)^2)
}

vex_y=function(x)
{
return(-x^2+10*x)
}


x=seq(1, 9, by=0.1)

plot(x, cave_y(x), type="l", col=pal_col[1],
	xlab="x", ylab="y")

lines(c(2, 4), cave_y(c(2, 4)), col=pal_col[2])
lines(c(3, 7), cave_y(c(3, 7)), col=pal_col[2])
lines(c(5, 6.5), cave_y(c(5, 6.5)), col=pal_col[2])


plot(x, vex_y(x), type="l", col=pal_col[1],
	xlab="x", ylab="y")

lines(c(2, 4), vex_y(c(2, 4)), col=pal_col[2])
lines(c(3, 7), vex_y(c(3, 7)), col=pal_col[2])
lines(c(5, 6.5), vex_y(c(5, 6.5)), col=pal_col[2])


