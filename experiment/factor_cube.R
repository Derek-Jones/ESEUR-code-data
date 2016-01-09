#
# factor_cube.R, 29 Jul 13
#
# Drawn colored planes representing how factors
# are interpreted in a fractional factorial experiment.
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

# At the moment only horizontal planes work redictably...

library("scatterplot3d")

box=data.frame(x=c(0, 1, 1, 0, 0, 1, 1, 0),
	       y=c(0, 0, 1, 1, 0, 0, 1, 1),
	       z=c(0, 0, 0, 0, 1, 1, 1, 1))


s3box=scatterplot3d(box,
		tick.marks=FALSE, grid=FALSE,
		angle=175,
		xlab="", ylab="", zlab="")

s3box$plane3d(0, 0, 0)
s3box$plane3d(1, 0, 0)

s3box$plane3d(0, 1, 0)
s3box$plane3d(1, -1, 0)

s3box$plane3d(0, 0, 1)
s3box$plane3d(1, 0, -1)

wireframe(z ~ x + y, data=box, groups=z, col="red")

box=data.frame(z=c(0, 0, 1, 1, 0, 0, 1, 1),
	       y=c(0, 1, 1, 0, 0, 1, 1, 0),
	       x=c(0, 0, 0, 0, 1, 1, 1, 1))
wireframe(z ~ x + y, data=box, groups=c(4,3,2,1), col="red")

