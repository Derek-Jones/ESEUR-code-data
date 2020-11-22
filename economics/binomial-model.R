#
# binomial-model.R, 19 Jun 20
# Data from:
# Example
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example_model binomial-model


source("ESEUR_config.r")


pal_col=rainbow(2)


u_line=function(x, y)
{
# lines(c(x, x+1), c(y, y+1), col=pal_col[1])
arrows(x0=x, x1=x+1, y0=y, y1=y+1, length=0.05, col=pal_col[1])
}


d_line=function(x, y)
{
# lines(c(x, x+1), c(y, y-1), col=pal_col[2])
arrows(x0=x, x1=x+1, y0=y, y1=y-1, length=0.05, col=pal_col[2])
}


u_text=function(x, y, t_str)
{
text(x, y, t_str, pos=3, cex=1.2)
}


d_text=function(x, y, t_str)
{
text(x, y, t_str, pos=1, cex=1.2)
}


r_text=function(x, y, t_str)
{
text(x, y, t_str, pos=4, cex=1.2)
}


dash_vertical=function(x, y, len)
{
lines(c(x, x), c(y+0.3, y-len-0.3), lty=2, col="grey")
}

plot(0, type="n", bty="n",
	xaxt="n", yaxt="n",
	xlim=c(0.7, 4.5), ylim=c(-3.7, 3.2),
	xlab="", ylab="")


u_line(1, 0); u_line(2, 1); u_line(3, 2)
d_line(1, 0); d_line(2, -1); d_line(3, -2)

u_line(2, -1); u_line(3, 0)
d_line(2, 1); d_line(3, 0)

u_line(3, -2)
d_line(3, 2)

dash_vertical(2, 1, 2)
dash_vertical(3, 2, 4)
dash_vertical(4, 3, 6)

text(1, 0, "S", pos=2, cex=1.5)

u_text(1.5, 0.5, "p")
d_text(1.5, -0.5, "1-p")

u_text(2, 1.3, "U")
d_text(2, -1.3, "D")


u_text(2.5, 1.5, expression(p^2))
d_text(2.5, -1.5, expression((1-p)^2))

u_text(3, 2.3, expression(U^2))
d_text(3, -2.3, expression(D^2))


u_text(3.5, 2.5, expression(p^3))
d_text(3.5, -2.5, expression((1-p)^3))

r_text(4, 3, expression(U^3))
r_text(4, -3, expression(D^3))


r_text(4, 1, expression(3*U^2*D))
r_text(4, -1, expression(3*D^2*U))

text(2.4, 0, expression(p*(1-p)), cex=1.2)
text(3.4, 1, expression(p^2*(1-p)), cex=1.2)
text(3.4, -1, expression(p*(1-p)^2), cex=1.2)

text(1, -3.7, "t=0", cex=1.2)
text(2, -3.7, "t=1", cex=1.2)
text(3, -3.7, "t=2", cex=1.2)
text(4, -3.7, "t=3", cex=1.2)
