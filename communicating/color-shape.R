#
# color-shape.R, 20 Sep 16
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

plot_layout(2, 1)

pal_col=rainbow(2)

plot(runif(30), runif(30), col=pal_col[1],
	xaxt="n", yaxt="n",
	xlim=c(0, 1), ylim=c(0, 1),
	xlab="", ylab="")
points(runif(30), runif(30), col=pal_col[2])

plot(runif(30), runif(30), col=point_col, pch=15,
	xaxt="n", yaxt="n",
	xlim=c(0, 1), ylim=c(0, 1),
	xlab="", ylab="")
points(runif(30), runif(30), col=point_col, pch=17)

