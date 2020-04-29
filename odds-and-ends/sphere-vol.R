#
# sphere-vol.R,  4 Apr 20
# Data from:
# Example
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example_sphere-volume


source("ESEUR_config.r")


par(mar=MAR_default+c(0.0, 0.7, 0, 0))


n=50

# Values for a recurence relationship
# sphere_vol[1]=1
# sphere_vol[2]=2
# d=3:n
#sphere_vol=sphere_vol[d-2]*2*pi/d
d=1:n
sphere_vol=pi^(d/2)/gamma(1+d/2)

plot(sphere_vol, log="y", col=point_col,
	xaxs="i",
	xlab="Dimensions", ylab="Volume\n\n")


