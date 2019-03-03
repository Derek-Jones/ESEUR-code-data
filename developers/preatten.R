#
# preatten.R,  1 Mar 19
# Data from:
# Based on example in:
# Information Visualization Perception for Design
# Colin Ware
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example vision attention

source("ESEUR_config.r")


set_width_height(max_width=8, max_height=16)
plot_layout(5, 2)
par(mar=c(1.4, 1, 1, 1))

# preatten.pic, 26 Dec 01

plot(0, type="n", bty="o", xaxt="n", yaxt="n", fg="grey",
	xlim=c(0, 1), ylim=c(0, 1),
	xlab="", ylab="")
axis(1, at=0.5, label="orientation")

llen=0.2

lines(c(0.1, 0.1), c(0.1, 0.1+llen), lwd=6, col=point_col)
lines(c(0.08, 0.08), c(0.6, 0.6+llen), lwd=6, col=point_col)
lines(c(0.26, 0.26), c(0.25, 0.25+llen), lwd=6, col=point_col)
lines(c(0.21, 0.21), c(0.77, 0.77+llen), lwd=6, col=point_col)
lines(c(0.13, 0.13+0.10), c(0.4, 0.4+sqrt(llen^2-0.10^2)), lwd=6, col=point_col)
lines(c(0.39, 0.39), c(0.2, 0.2+llen), lwd=6, col=point_col)
lines(c(0.35, 0.35), c(0.7, 0.7+llen), lwd=6, col=point_col)
lines(c(0.5, 0.5), c(0.07, 0.07+llen), lwd=6, col=point_col)
lines(c(0.58, 0.58), c(0.5, 0.5+llen), lwd=6, col=point_col)
lines(c(0.7, 0.7), c(0.15, 0.15+llen), lwd=6, col=point_col)
lines(c(0.73, 0.73), c(0.8, 0.8+llen), lwd=6, col=point_col)
lines(c(0.96, 0.96), c(0.3, 0.3+llen), lwd=6, col=point_col)
lines(c(0.92, 0.92), c(0.7, 0.7+llen), lwd=6, col=point_col)


a_curve=function(x, y)
{
half_len=length(circle_x_pts)/4
lines(x+head(circle_x_pts, n=half_len), y+head(circle_y_pts, n=half_len),
			lwd=5, col=point_col)
}

circum=c(seq(0, 0.10, by=0.001))
circle_x_pts=c(circum, rev(circum), -circum, -rev(circum))
circle_y_pts=c(-sqrt(0.0101-circum^2), +sqrt(0.0101-rev(circum)^2),
                sqrt(0.0101-circum^2), -sqrt(0.0101-rev(circum)^2))

plot(0, type="n", bty="o", xaxt="n", yaxt="n", fg="grey",
	xlim=c(0, 1), ylim=c(0, 1),
	xlab="", ylab="")
axis(1, at=0.5, label="curved/straight")

llen=0.13

a_curve(0.1, 0.1)
a_curve(0.05, 0.6)
a_curve(0.26, 0.35)
a_curve(0.28, 0.87)
a_curve(0.10, 0.92)
lines(c(0.39, 0.39+0.09), c(0.57, 0.57+sqrt(llen^2-0.09^2)), lwd=5, col=point_col)
a_curve(0.39, 0.57)
# a_curve(0.35, 0.7)
a_curve(0.75, 0.08)
a_curve(0.58, 0.8)
a_curve(0.6, 0.35)
a_curve(0.83, 0.92)
a_curve(0.9, 0.5)
a_curve(0.82, 0.7)


a_circle=function(x, y, cex_size=2, col_str=point_col)
{
points(x, y, pch=19, cex=cex_size, col=col_str)
}


plot(0, type="n", bty="o", xaxt="n", yaxt="n", fg="grey",
	xlim=c(0, 1), ylim=c(0, 1),
	xlab="", ylab="")
axis(1, at=0.5, label="shape")

llen=0.10

a_circle(0.1, 0.1)
a_circle(0.05, 0.6)
a_circle(0.26, 0.35)
a_circle(0.28, 0.87)
a_circle(0.10, 0.92)
lines(c(0.55, 0.55+llen), c(0.6, 0.6), lwd=4, col=point_col)
a_circle(0.39, 0.57)
a_circle(0.35, 0.7)
a_circle(0.75, 0.08)
a_circle(0.58, 0.8)
a_circle(0.6, 0.35)
a_circle(0.83, 0.92)
a_circle(0.9, 0.5)
a_circle(0.82, 0.7)


plot(0, type="n", bty="o", xaxt="n", yaxt="n", fg="grey",
	xlim=c(0, 1), ylim=c(0, 1),
	xlab="", ylab="")
axis(1, at=0.5, label="shape")

llen=0.2

lines(c(0.1, 0.1), c(0.1, 0.1+llen), lwd=4, col=point_col)
lines(c(0.08, 0.08), c(0.6, 0.6+llen), lwd=4, col=point_col)
lines(c(0.26, 0.26), c(0.25, 0.25+llen), lwd=4, col=point_col)
lines(c(0.21, 0.21), c(0.77, 0.77+llen), lwd=4, col=point_col)
lines(c(0.13, 0.13), c(0.4, 0.4+llen), lwd=4, col=point_col)
lines(c(0.39, 0.39), c(0.2, 0.2+0.7*llen), lwd=8, col=point_col)
lines(c(0.35, 0.35), c(0.7, 0.7+llen), lwd=4, col=point_col)
lines(c(0.5, 0.5), c(0.07, 0.07+llen), lwd=4, col=point_col)
lines(c(0.58, 0.58), c(0.5, 0.5+llen), lwd=4, col=point_col)
lines(c(0.7, 0.7), c(0.15, 0.15+llen), lwd=4, col=point_col)
lines(c(0.73, 0.73), c(0.8, 0.8+llen), lwd=4, col=point_col)
lines(c(0.96, 0.96), c(0.3, 0.3+llen), lwd=4, col=point_col)
lines(c(0.92, 0.92), c(0.7, 0.7+llen), lwd=4, col=point_col)

plot(0, type="n", bty="o", xaxt="n", yaxt="n", fg="grey",
        xlim=c(0, 1), ylim=c(0, 1),
        xlab="", ylab="")
axis(1, at=0.5, label="size")

a_circle(0.1, 0.1, 1.2)
a_circle(0.05, 0.6, 1.2)
a_circle(0.26, 0.35, 1.2)
a_circle(0.28, 0.87, 1.2)
a_circle(0.10, 0.92, 1.2)
a_circle(0.55, 0.6, 2.7)
a_circle(0.39, 0.57, 1.2)
a_circle(0.35, 0.7, 1.2)
a_circle(0.75, 0.08, 1.2)
a_circle(0.58, 0.8, 1.2)
a_circle(0.6, 0.35, 1.2)
a_circle(0.83, 0.92, 1.2)
a_circle(0.9, 0.5, 1.2)
a_circle(0.82, 0.7, 1.2)



plot(0, type="n", bty="o", xaxt="n", yaxt="n", fg="grey",
        xlim=c(0, 1), ylim=c(0, 1),
        xlab="", ylab="")
axis(1, at=0.5, label="size")

a_circle(0.1, 0.1, 2)
a_circle(0.05, 0.6, 2)
a_circle(0.26, 0.35, 2, col_str="green")
a_circle(0.28, 0.87, 2)
a_circle(0.10, 0.92, 2)
a_circle(0.55, 0.6, 2)
a_circle(0.39, 0.57, 2)
a_circle(0.35, 0.7, 2)
a_circle(0.75, 0.08, 2)
a_circle(0.58, 0.8, 2)
a_circle(0.6, 0.35, 2)
a_circle(0.83, 0.92, 2)
a_circle(0.9, 0.5, 2)
a_circle(0.82, 0.7, 2)


enclosure=function(x, y, offset=0)
{
points(x, y, pch=1, cex=3, col=point_col)
points(x+offset, y+offset, pch=19, cex=1, col=point_col)
}


plot(0, type="n", bty="o", xaxt="n", yaxt="n", fg="grey",
        xlim=c(0, 1), ylim=c(0, 1),
        xlab="", ylab="")
axis(1, at=0.5, label="enclosure")

enclosure(0.1, 0.1)
enclosure(0.05, 0.6)
enclosure(0.26, 0.35)
enclosure(0.28, 0.87)
enclosure(0.10, 0.92)
enclosure(0.55, 0.6)
enclosure(0.41, 0.51)
enclosure(0.35, 0.7)
enclosure(0.75, 0.08)
enclosure(0.58, 0.8)
enclosure(0.6, 0.35, -0.08)
enclosure(0.83, 0.92)
enclosure(0.9, 0.5)
enclosure(0.82, 0.7)


pt_number=function(x, y)
{
x1_off=ifelse(runif(1) > 0.5, 0.04, -0.04)
x2_off=ifelse(runif(1) > 0.5, 0.04, -0.04)
y_off=ifelse(runif(1) > 0.5, 0.06, -0.06)
points(x, y, pch=19, cex=1, col=point_col)
points(x+x1_off, y, pch=19, cex=1, col=point_col)
points(x+x2_off, y+y_off, pch=19, cex=1, col=point_col)
}

set.seed(5)

plot(0, type="n", bty="o", xaxt="n", yaxt="n", fg="grey",
        xlim=c(0, 1), ylim=c(0, 1),
        xlab="", ylab="")
axis(1, at=0.5, label="number")

pt_number(0.1, 0.1)
pt_number(0.05, 0.6)
pt_number(0.26, 0.35)
pt_number(0.31, 0.89)
pt_number(0.10, 0.92)
pt_number(0.65, 0.55)
pt_number(0.42, 0.57)
# pt_number(0.35, 0.7)
points(0.35, 0.7, pch=19, cex=1, col=point_col)
pt_number(0.75, 0.08)
pt_number(0.58, 0.8)
pt_number(0.6, 0.35)
pt_number(0.83, 0.92)
pt_number(0.9, 0.5)
pt_number(0.82, 0.7)


plot(0, type="n", bty="o", xaxt="n", yaxt="n", fg="grey",
	xlim=c(0, 1), ylim=c(0, 1),
	xlab="", ylab="")
axis(1, at=0.5, label="addition")

llen=0.2
x_b=0.26
y_b=0.25

lines(c(0.1, 0.1), c(0.1, 0.1+llen), lwd=4, col=point_col)
lines(c(0.08, 0.08), c(0.6, 0.6+llen), lwd=4, col=point_col)
lines(c(x_b, x_b), c(y_b, y_b+llen), lwd=4, col=point_col)
polygon(c(x_b-0.03, x_b+0.03, x_b+0.03, x_b-0.03),
        c(y_b-0.05, y_b-0.05, y_b+llen+0.05, y_b+llen+0.05), border=point_col)

lines(c(0.21, 0.21), c(0.77, 0.77+llen), lwd=4, col=point_col)
lines(c(0.13, 0.13), c(0.4, 0.4+llen), lwd=4, col=point_col)
lines(c(0.39, 0.39), c(0.2, 0.2+llen), lwd=4, col=point_col)
lines(c(0.35, 0.35), c(0.7, 0.7+llen), lwd=4, col=point_col)
lines(c(0.5, 0.5), c(0.07, 0.07+llen), lwd=4, col=point_col)
lines(c(0.58, 0.58), c(0.5, 0.5+llen), lwd=4, col=point_col)
lines(c(0.7, 0.7), c(0.15, 0.15+llen), lwd=4, col=point_col)
lines(c(0.73, 0.73), c(0.8, 0.8+llen), lwd=4, col=point_col)
lines(c(0.96, 0.96), c(0.3, 0.3+llen), lwd=4, col=point_col)
lines(c(0.92, 0.92), c(0.7, 0.7+llen), lwd=4, col=point_col)


plot(0, type="n", bty="o", xaxt="n", yaxt="n", fg="grey",
        xlim=c(0, 1), ylim=c(0, 1),
        xlab="", ylab="")
axis(1, at=0.5, label="mixed")

lines(c(0.13, 0.13+0.10), c(0.7, 0.7+sqrt(llen^2-0.10^2)), lwd=6, col=point_col)

llen=0.2
x_b=0.06
y_b=0.25
lines(c(x_b, x_b), c(y_b, y_b+llen), lwd=4, col=point_col)
polygon(c(x_b-0.03, x_b+0.03, x_b+0.03, x_b-0.03),
        c(y_b-0.05, y_b-0.05, y_b+llen+0.05, y_b+llen+0.05), border=point_col)

lines(c(0.59, 0.59), c(0.2, 0.2+0.7*llen), lwd=8, col=point_col)
a_curve(0.7, 0.85)
a_circle(0.55, 0.6, 2.7)
a_circle(0.26, 0.35, 2, col_str="green")
enclosure(0.9, 0.35, -0.08)

llen=0.2

lines(c(0.4, 0.4), c(0.8, 0.8+llen), lwd=6, col=point_col)
lines(c(0.95, 0.95), c(0.6, 0.6+llen), lwd=6, col=point_col)
lines(c(0.33, 0.33), c(0.08, 0.08+llen), lwd=6, col=point_col)


# right_ang=function(x, y)
# {
# x_off=ifelse(runif(1) > 0.5, 0.05, -0.05)
# lines(c(x, x, x+x_off), c(y, y+0.1, y+0.1), lwd=1.5, col=point_col)
# }
# 
# set.seed(5)
# 
# plot(0, type="n", bty="o", xaxt="n", yaxt="n", fg="grey",
#         xlim=c(0, 1), ylim=c(0, 1),
#         xlab="", ylab="")
# axis(1, at=0.5, label="juncture")
# 
# right_ang(0.1, 0.1)
# right_ang(0.05, 0.6)
# right_ang(0.26, 0.35)
# right_ang(0.31, 0.89)
# right_ang(0.10, 0.92)
# right_ang(0.65, 0.55)
# right_ang(0.42, 0.57)
# # right_ang(0.35, 0.7)
# x=0.35; y= 0.7
# lines(c(x, x), c(y, y+0.1), lwd=1.5, col=point_col)
# lines(c(x-0.02, x-0.05), c(y+0.1, y+0.1), lwd=1.5, col=point_col)
# right_ang(0.75, 0.08)
# right_ang(0.58, 0.8)
# right_ang(0.6, 0.35)
# right_ang(0.83, 0.92)
# right_ang(0.9, 0.5)
# right_ang(0.82, 0.7)
# 
# 
