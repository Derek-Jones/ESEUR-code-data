#
# kubovy08.R, 15 Mar 18
# Data from:
# The Whole Is Equal to the Sum of Its Parts: {A} Probabilistic Model of Grouping by Proximity and Similarity in Regular Patterns
# Michael Kubovy and Martin {van den Berg}
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(1, 1, default_height=12)
par(mar=c(1, 1, 1, 0))


plot_sym=function(x_start, y, number, color, shape)
{
points(x_start:(x_start+number-1), rep(y, number), col=color, pch=shape, cex=4)
}


box=15
triangle=17

plot(0, type="n", bty="n", xaxt="n", yaxt="n", xaxs="i", yaxs="i",
	xlim=c(0.7, 7.5), ylim=c(0.25, 7.3),
	xlab="", ylab="")

plot_sym(1, 7, 4, "green", box)
plot_sym(5.3, 7, 3, "green", box)
text(4, 6.8, "Grouping by proximity", pos=1)

plot_sym(1, 6, 3, "red", box)
plot_sym(4, 6, 1, "green", box)
plot_sym(5.3, 6, 3, "green", box)
text(4, 5.8, "Grouping by color similarity vs grouping by proximity", pos=1)

plot_sym(1, 5, 3, "green", triangle)
plot_sym(4, 5, 1, "green", box)
plot_sym(5.3, 5, 3, "green", box)
text(4, 4.8, "Grouping by shape similarity vs grouping by proximity", pos=1)

plot_sym(1, 4, 4, "green", box)
plot_sym(5, 4, 3, "red", box)
text(4, 3.8, "Grouping by color similarity", pos=1)

plot_sym(1, 3, 4, "green", box)
plot_sym(5, 3, 3, "green", triangle)
text(4, 2.8, "Grouping by shape similarity", pos=1)

plot_sym(1, 2, 3, "green", triangle)
plot_sym(4, 2, 1, "green", box)
plot_sym(5, 2, 3, "red", box)
text(4, 1.8, "Grouping by color similarity vs grouping by shape similarity", pos=1)

plot_sym(1, 1, 3, "green", triangle)
plot_sym(4, 1, 1, "green", box)
plot_sym(5.3, 1, 3, "green", box)
text(4, 0.8, "Grouping by proximity & color similarity vs\ngrouping by shape similarity", pos=1)


