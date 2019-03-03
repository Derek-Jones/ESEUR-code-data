#
# gestalt.R, 30 Nov 16
# Data from:
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example vision gestalt


source("ESEUR_config.r")


set_width_height(max_width=8, max_height=16)
plot_layout(5, 2)
par(mar=c(1.4, 1, 1, 1))

# closure.pic, 26 Dec 01

plot(0, type="n", bty="n", xaxt="n", yaxt="n",
	xlim=c(0, 3), ylim=c(-2, 0),
	xlab="", ylab="")

lines(spline(c(0.0, 0.5, 2.5, 3.0),
		 c(-0.5, 0.0, -2.0, -1.5), n=30), col=point_col)
lines(spline(c(0.0, 0.5, 2.5, 3.0),
		 c(-1.5, -2.0, 0.0, -0.5), n=30), col=point_col)

plot(0, type="n", bty="n", xaxt="n", yaxt="n",
        xlim=c(0, 3), ylim=c(-1.1, 1.1),
        xlab="", ylab="")
lines(spline(c(0.0, 0.5, 1.0, 1.5, 2.0, 2.5),
		 c(0.0,-0.5,-0.2,-0.2,-1.0,-0.0), n=30), col=point_col)
lines(spline(c(0.0, 0.5, 1.0, 1.5, 2.0, 2.5),
		 c(0.1, 0.6, 0.3, 0.3, 1.1, 0.1), n=30), col=point_col)

# plot(0, type="n", bty="n", xaxt="n", yaxt="n",
#         xlim=c(0, 3), ylim=c(1.9, 2.7),
#         xlab="", ylab="")
# lines(spline(c(0.0, 0.5, 1.0, 1.5, 2.0, 2.5),
#		 c(2.0, 2.1, 2.2, 2.25, 2.2, 1.9), n=30), col=point_col)
# lines(spline(c(0.0, 0.5, 1.0, 1.5, 2.0, 2.5),
#		 c(2.6, 2.5, 2.4, 2.33, 2.4, 2.7), n=30), col=point_col)

# plot(0, type="n", bty="n", xaxt="n", yaxt="n",
#         xlim=c(0, 3), ylim=c(0.2, 1.3),
#         xlab="", ylab="")
# lines(spline(c(0.0, 0.5, 1.0, 1.5, 2.0, 2.5),
#		 c(1.0, 0.5, 0.8, 0.8, 0.2, 1.0), n=30), col=point_col)
# lines(spline(c(0.0, 0.5, 1.0, 1.5, 2.0, 2.5),
#		 c(1.3, 0.8, 1.1, 1.1, 0.5, 1.3), n=30), col=point_col)

plot(0, type="n", bty="n", xaxt="n", yaxt="n",
        xlim=c(0, 3), ylim=c(-0.8, 0.2),
        xlab="", ylab="")
lines(spline(c(0.0, 0.5, 1.0, 1.5, 2.0, 2.5),
		 c(-0.5,-0.3,-0.5,-0.7,-0.2,-0.5), n=30), col=point_col)
lines(spline(c(0.0, 0.5, 1.0, 1.5, 2.0, 2.5),
		 c(-0.2, 0.0,-0.2,-0.4, 0.1,-0.2), n=30), col=point_col)

plot(0, type="n", bty="n", xaxt="n", yaxt="n",
        xlim=c(1, 6), ylim=c(1, 6),
        xlab="", ylab="")

y_pts=seq(1, 6, by=0.7)
x_pts=seq(1, 6)

dummy=sapply(y_pts, function(X) points(x_pts, rep(X, length(x_pts)), pch=19, col=point_col))

plot(0, type="n", bty="n", xaxt="n", yaxt="n",
        xlim=c(1, 6), ylim=c(1, 6),
        xlab="", ylab="")

y1_pts=seq(1, 6, by=1.4)
y2_pts=seq(1.7, 6, by=1.4)
x_pts=seq(1, 6)

dummy=sapply(y1_pts, function(X) points(x_pts, rep(X, length(x_pts)), pch=20, col=point_col))
dummy=sapply(y2_pts, function(X) points(x_pts, rep(X, length(x_pts)), pch=4, col=point_col))



plot(0, type="n", bty="n", xaxt="n", yaxt="n",
	xlim=c(0, 3), ylim=c(-2, 0),
	xlab="", ylab="")

lines(spline(c(0.0, 0.5, 2.5, 3.0), c(-0.5, 0.0, -2.0, -1.5), n=30), col=point_col)
lines(spline(c(3.0, 2.7), c(-1.5, -1.0), n=20), col=point_col)
lines(spline(c(2.7, 3.0), c(-1.0, -0.5), n=20), col=point_col)
lines(spline(c(0.0, 0.5, 2.5, 3.0),
		 c(-1.5, -2.0, 0.0, -0.5), n=30), col=point_col)
lines(spline(c(0.0, 0.3), c(-1.5, -1.0), n=20), col=point_col)
lines(spline(c(0.3, 0.0), c(-1.0, -0.5), n=20), col=point_col)


# continu.pic, 26 Dec 01


# box ht 1.0 wid 1.5 at 0.0,-4.0
# move to -0.7,-3.2
# line right; arc cw; line ; arc ; arc ; line; arc cw
# 
# box ht 1.0 wid 1.5 at 2.5,-4.4
# move to 1.8,-2.8
# line right; arc cw; line ; arc ; arc ; line; arc cw
# 
# move to 4.3,-2.8
# line right; arc cw; line right 0.5; arc up cw
# 
# move to 4.35,-3.5
# line down 1.0
# line right 1.5
# line up 1.0
# line left 0.5
# line down 0.3; arc cw; arc cw; line up 0.3;
# line left 0.5


# symmetric

plot(0, type="n", bty="n", xaxt="n", yaxt="n",
        xlim=c(0, 3), ylim=c(0.5, 2),
        xlab="", ylab="")
lines(spline(c(0.0, 0.5, 1.0, 1.5, 2.0, 2.5),
		 c(1.0, 1.2, 1.0, 0.8, 1.2, 1.0), n=30), col=point_col)
lines(spline(c(0.0, 0.5, 1.0, 1.5, 2.0, 2.5),
		 c(1.6, 1.4, 1.6, 1.8, 1.4, 1.6), n=30), col=point_col)

# parallel

plot(0, type="n", bty="n", xaxt="n", yaxt="n",
        xlim=c(0, 3), ylim=c(1.5, 2.2),
        xlab="", ylab="")
lines(spline(c(0.0, 0.5, 1.0, 1.5, 2.0, 2.5),
		 c(1.8, 1.7, 1.6, 1.5, 1.6, 1.9), n=30), col=point_col)
lines(spline(c(0.0, 0.5, 1.0, 1.5, 2.0, 2.5),
		 c(2.1, 2.0, 1.9, 1.8, 1.9, 2.2), n=30), col=point_col)

# proximity.pic,


plot(0, type="n", bty="n", xaxt="n", yaxt="n",
        xlim=c(1, 6), ylim=c(1, 6),
        xlab="", ylab="")

y_pts=seq(1, 6)
x_pts=seq(1, 6, by=0.7)

dummy=sapply(y_pts, function(X) points(x_pts, rep(X, length(x_pts)), pch=19, col=point_col))


plot(0, type="n", bty="n", xaxt="n", yaxt="n",
        xlim=c(1, 6), ylim=c(1, 6),
        xlab="", ylab="")

y1_pts=seq(1, 6, by=1.4)
y2_pts=seq(1.7, 6, by=1.4)
x_pts=seq(1, 6)

dummy=sapply(y1_pts, function(X) points(x_pts, rep(X, length(x_pts)), pch=19))
dummy=sapply(y2_pts, function(X) points(x_pts, rep(X, length(x_pts)), pch=19, col="red"))


