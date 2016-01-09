#
# 3D-error-distrib.R, 30 Dec 15
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")
library("scatterplot3d")


# Outer Margin Area, default: par(oma=c(3, 3, 3, 3))
par(oma=c(2, 1, 1, 1))

disp_angle=20

max_x=5
max_y=7

x_points=c(1, 2, 3, 4, 5)
y_points=c(1, 2, 2, 4, 3)

brew_col=rainbow(length(x_points))

max_z=max(dnorm(1, mean=1, sd=1.2))

plot_gauss_err=function(y_val)
{
cur_x=x_points[y_val]
cur_y=y_pred[y_val]
y=seq(-2, max_y, 0.1)
x=rep(cur_x, length(y))
# sd picked to look good
z=dnorm(y, mean=cur_y, sd=1.2)
par(new=TRUE)
s3m=scatterplot3d(x, y, z, type="l", color=brew_col[y_val],
	angle=disp_angle, box=FALSE,
	scale.y=1.7,
	xlab="", ylab="", zlab="", z.ticklabs="",
	xlim=c(0, max_x), ylim=c(-2.0, max_y), zlim=c(0, 1.1*max_z),
	mar=c(4, 2, 0, 1)+0.1,
	cex.axis=0.7, cex.lab=0.7,
	col.axis = "grey",
	col.grid = "lightgrey")

# pch has to be something innocuous
s3m$points3d(cur_x, cur_y, max_z, col="black", type="h", pch=".")
}

n_mod=glm(y_points ~ x_points)
y_pred=predict(n_mod)
z_points=rep(0, length(x_points))

s3m=scatterplot3d(x_points, y_pred, z_points, type="l", color="black",
	angle=disp_angle, box=FALSE,
	scale.y=1.7,
	xlab="X", ylab="Y", zlab="Error probability", z.ticklabs="",
#	sub = "Gaussian error distribution",
	xlim=c(0, max_x), ylim=c(-2.0, max_y), zlim=c(0, 1.1*max_z),
	mar=c(4, 2, 0, 1)+0.1,
	cex.axis=0.7, cex.lab=0.7,
	col.axis = "grey",
	col.grid = "lightgrey")
s3m$points3d(x_points, y_points, z_points, col="red", pch=8)


a_ply(1:4, 1, plot_gauss_err)


y_points=c(1, 2, 2, 4, 3)
max_z=max(dpois(min(y_points), lambda=min(y_points)))

plot_pois_err=function(y_val)
{
cur_x=x_points[y_val]
cur_y=y_pred[y_val]
y=seq(0, max_y, 1)
x=rep(cur_x, length(y))
z=dpois(y, lambda=cur_y)
loc_max_z=max(z)
par(new=TRUE)
s3m=scatterplot3d(x, y, z, type="l", color=brew_col[y_val],
	angle=disp_angle, box=FALSE,
	scale.y=1.7,
	xlab="", ylab="", zlab="", z.ticklabs="",
	xlim=c(0, max_x), ylim=c(-2, max_y), zlim=c(0, 1.1*max_z),
	mar=c(4, 2, 0, 1)+0.1,
	cex.axis=0.7, cex.lab=0.7,
	col.axis = "grey",
	col.grid = "lightgrey")

# pch has to be something innocuous
# Top of line won't line up because predicted y has a non-integer value...
s3m$points3d(cur_x, cur_y, 0.95*loc_max_z, col="black", type="h", pch=".")
}

# p_mod=glm(y_points ~ x_points, family=poisson)
# y_pred=predict(p_mod, type="response")
# z_points=rep(0, length(x_points))

# s3m=scatterplot3d(x_points, y_pred, z_points, type="l", color="black",
# 	angle=disp_angle, box=FALSE,
# 	scale.y=1.7,
# 	xlab="X", ylab="Y", zlab="", z.ticklabs="",
# 	sub = "Poisson error distribution",
# 	xlim=c(0, max_x), ylim=c(-2, max_y), zlim=c(0, 1.1*max_z),
# 	mar=c(4, 2, 0, 1)+0.1,
#	cex.axis=0.7, cex.lab=0.7,
# 	col.axis = "grey",
# 	col.grid = "lightgrey")
# s3m$points3d(x_points, y_points, z_points, col="red", pch=8)
# 
# 
# a_ply(1:4, 1, plot_pois_err)

