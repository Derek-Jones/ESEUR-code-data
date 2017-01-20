#
# above-below-light.R, 26 Dec 16
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")

# step size of 0.005 and 60 shades of grey produce acceptable size of pdf

shade_col=sequential_hcl(60, c=0, power=2.2)
#shade_col=rev(shade_col)

# Got the algorithm below from rosetta code.
#
# The following ideas produces images that did not look realistic.
# Calculate distance from a point y_offset from the
# circle, i.e., a light source.
# Simulate a boundary using a logistic equation, numbers
# fitted so boundary occurs roughly in the middle of the circle.
ld_boundary=function(x_vals, y_vals)
{
dist=sqrt(1.001-x_vals^2-y_vals^2)
#dist=sqrt(x_vals^2+(y_offset+y_vals)^2)

col=shade_col[22+30*(dist-(x_vals+y_vals)/2.0)]
if (length(y_vals) != length(col)) print(x_vals[1])

return(col)
}

# for (X in c(seq(-1, 1, 0.2), 0.387, 0.445))
#    {
# y_vals=seq(-sqrt(1-X^2), sqrt(1-X^2), by=0.001)
# x_vals=rep(X, length(y_vals))
# dist=sqrt(1.0001-x_vals^2-y_vals^2)
# c=22+30*(dist-(x_vals+y_vals)/2.0)
# print(c(min(c), max(c), which(c < 1)))
#    }
# plot(c)
#ld=ld_boundary(x_vals, y_vals)


mk_pt=function(X)
{
y_vals=seq(-sqrt(1-X^2), sqrt(1-X^2), by=0.005)
x_vals=rep(X, length(y_vals))

return(data.frame(x=x_vals,
		  y=y_vals,
		  col=ld_boundary(x_vals, y_vals)))
}


plot_light_above=function(x_offset, y_offset=3.2)
{
points(x_offset+shade_pts$x, y_offset-shade_pts$y, col=shade_pts$col, pch=".")
}

plot_light_below=function(x_offset, y_offset=3.1)
{
# Reverse x-points so light source comes from the same direction
# as plot_light_above
points(x_offset+rev(shade_pts$x), y_offset+shade_pts$y, col=shade_pts$col, pch=".")
}


x_vals=seq(-1, 1, by=0.005)

shade_pts=adply(x_vals, 1, mk_pt)
shade_pts$col=as.character(shade_pts$col)

plot(0, type="n", axes=FALSE,
	xlim=c(0, 11.2), ylim=c(0, 11.2),
	xlab="", ylab="")

polygon(c(0, 20, 20, 0, 0),
	c(0,  0, 20, 20, 0), col=shade_col[25], border=NA)

plot_light_above(1.2, 9.2)
plot_light_above(4.2, 9.2)
plot_light_above(7.2, 9.2)
plot_light_above(10.2, 9.2)

plot_light_below(1.2)
plot_light_below(4.2)
plot_light_below(7.2)
plot_light_below(10.2)

