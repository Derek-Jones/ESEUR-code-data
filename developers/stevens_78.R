#
# stevens_78.R, 25 Dec 19
# Data from:
# Based on an example in:
# Distortions in Judged Spatial Relations
# Albert Stevens and Patty Coupe
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human spatial_relationship


source("ESEUR_config.r")


set_width_height(max_width=8, max_height=12)
plot_layout(3, 2)
par(mar=c(2.5, 2.5, 0.8, 0.5))
par(cex.lab=1.5)


pal_col=rainbow(3)

mk_outline=function(x_str)
{
plot(0, type="n", bty="o", fg="grey", xaxp=c(0, 2, 2),
	xaxt="n", yaxt="n",
	xaxs="i", yaxs="i",
	xlim=c(0, 2), ylim=c(0, 2),
	xlab=x_str, ylab="")

text(0.3, 1.8, "Alpha\nCountry", cex=1.2)
text(1.7, 0.2, "Beta\nCountry", cex=1.2)
}

mk_left_map=function(x_str)
{
mk_outline(x_str)
text(1-0.1, 1, ".", cex=4.0, col=pal_col[1])
text(1-0.1, 1, "X", cex=2.0, pos=1, col=pal_col[3])
text(1+0.1, 0+0.25, ".", cex=4.0, col=pal_col[1])
text(1+0.1, 0+0.25, "Y", cex=2.0, pos=1, col=pal_col[3])
text(1+0.6, 1+0.4, ".", cex=4.0, col=pal_col[1])
text(1+0.6, 1+0.4, "Z", cex=2.0, pos=1, col=pal_col[3])
}

mk_right_map=function(x_str)
{
mk_outline(x_str)
text(1, 1-0.1, ".", cex=4.0, col=pal_col[1])
text(1, 1-0.1, "X", cex=2.0, pos=4, col=pal_col[3])
text(1+0.65, 1+0.1, ".", cex=4.0, col=pal_col[1])
text(1+0.65, 1+0.1, "Y", cex=2.0, pos=4, col=pal_col[3])
text(1-0.5, 1+0.5, ".", cex=4.0, col=pal_col[1])
text(1-0.5, 1+0.5, "Z", cex=2.0, pos=4, col=pal_col[3])
}


mk_left_map("Congruent")
lines(c(1, 1), c(0, 2), col=pal_col[2])

mk_left_map("Incongruent")
t=spline(y=c(1, 0.65, 0.5, 1.3, 1.1), x=c(2, 1.5, 1.0, 0.5, 0.0), n=30)
lines(t$y, t$x, col=pal_col[2])

mk_left_map("Homogeneous")

mk_right_map("Congruent")
lines(c(0, 2), c(1, 1), col=pal_col[2])

mk_right_map("Incongruent")
t=spline(y=c(1, 0.65, 0.5, 1.3, 1.1), x=c(2, 1.5, 1.0, 0.5, 0.0), n=30)
lines(t$x, rev(t$y), col=pal_col[2])

mk_right_map("Homogeneous")

