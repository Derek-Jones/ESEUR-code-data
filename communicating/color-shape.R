#
# color-shape.R,  4 Mar 20
# Data from:
# Example
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example_color

source("ESEUR_config.r")


plot_layout(2, 1, max_height=9)
par(mar=MAR_default-c(2.7, 0.0, 0.5, 0.0))


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

