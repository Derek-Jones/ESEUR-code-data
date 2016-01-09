#
# pop-sample.R, 20 Sep 14
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


draw_circle=function(x, y, rad)
{
angles<-seq(0, 2*pi, by=0.01)
xt<-x+cos(angles)*rad
yt<-y+sin(angles)*rad
polygon(xt, yt, border="grey")
}


pop_rad=0.75

# Generate random points inside the circle
r_circ=function(pop_size)
{
# The sum of two uniformly distributed random numbers has a
# triangle distribution (think of sliver of circle as being a triangle).
d_rad=runif(pop_size)+runif(pop_size)
# Fold back other 'half' of triangle.
d_rad[d_rad > 1]=2-d_rad[d_rad > 1]
d_ang=2*pi*runif(pop_size)
x_pts=d_rad*cos(d_ang)
y_pts=d_rad*sin(d_ang)

return(data.frame(x=x_pts, y=y_pts))
}

pts=r_circ(500)
pts$x=pop_rad*(1+pts$x)
pts$y=pop_rad*(1+pts$y)

plot(pts$x, pts$y, pch=21, cex=0.2, col="red",
	bty="n", xaxt="n", yaxt="n",
	xlim=c(0, 2.5), ylim=c(0, 2.5),
	xlab="", ylab="")

draw_circle(pop_rad, pop_rad, pop_rad)
text(pop_rad, 0.1+pop_rad*2, "Population", cex=1.2)

samp_rad=pop_rad/3
samp_x=3*pop_rad
samp_y=pop_rad

draw_circle(samp_x, samp_y, samp_rad)
text(samp_x, 0.1+samp_y+samp_rad, "Sample", cex=1.2)

samp_x_pts=samp_x+c(0, 0.5, 0.5, -0.5, -0.5)*samp_rad
samp_y_pts=samp_y+c(0, -0.5, 0.5, 0.5, -0.5)*samp_rad

points(samp_x_pts, samp_y_pts, pch=21, col="red")

pop_x_pts=pts$x[1:5]
pop_y_pts=pts$y[1:5]

arrows(pop_x_pts, pop_y_pts, samp_x_pts, samp_y_pts,
	length=0.1)

