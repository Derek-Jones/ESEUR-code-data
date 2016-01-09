#
# strata-sample.R, 14 Dec 15
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

strata_samp=function(x, strata_col)
{

samp_x=x
samp_y=0.5

draw_circle(samp_x, samp_y, sample_rad)
text(samp_x, 0.1+samp_y+sample_rad, "Strata", col=pal_col[strata_col], cex=1.2)

strata_pts=r_circ(num_strata_pts+20)
sample_col=c(rep(strata_col, num_strata_pts),
	     sample(1:num_colors, 20, replace=TRUE))

samp_x_pts=samp_x+sample_rad*strata_pts$x
samp_y_pts=samp_y+sample_rad*strata_pts$y

points(samp_x_pts, samp_y_pts, pch=21, cex=0.3, col=pal_col[sample_col])
}



num_colors=3
pal_col=rainbow(num_colors)

num_pts=350
num_strata_pts=40

sample_col=sample(1:num_colors, num_pts, replace=TRUE)
x=runif(num_pts, 0, 2.5)
y=runif(num_pts, 1.25, 2.5)

plot(x, y, pch=21, cex=0.3, col=pal_col[sample_col],
	bty="n", xaxt="n", yaxt="n",
	xlim=c(0, 2.5), ylim=c(0, 2.5),
	xlab="", ylab="")


sample_rad=0.35

strata_samp(sample_rad+0.1, 1)
strata_samp(3*sample_rad+2*0.1, 2)
strata_samp(5*sample_rad+3*0.1, 3)


