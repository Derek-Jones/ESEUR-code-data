#
# checker.R,  6 Jan 18
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


top_sq=function(x, y, pl_col="yellow")
{
polygon(c(x, x+xl[1], x+xl[1]+yl[1], x+yl[1], x),
      c(y, y+xl[2], y+xl[2]+yl[2], y+yl[2], y), col=pl_col, border=pl_col)
}


left_sq=function(x, y, pl_col="yellow")
{
polygon(c(x, x+xl[1], x+xl[1]+zl[1], x+zl[1], x),
      c(y, y+xl[2], y+xl[2]+zl[2], y+zl[2], y), col=pl_col, border=pl_col)
}

right_sq=function(x, y, pl_col="yellow")
{
polygon(c(x, x+yl[1], x+yl[1]+zl[1], x+zl[1], x),
      c(y, y+yl[2], y+yl[2]+zl[2], y+zl[2], y), col=pl_col, border=pl_col)
}

greys=sequential_hcl(12, c = 0, power = 2.2)

base_x=0.0 ; base_y=0.5

xl=4*c(0.07, 0.01)
yl=4*c(0.046, 0.085)
zl=4*c(0.074, -0.07)


plot(0, type="n", bty="n", xaxt="n", yaxt="n",
	xlim=c(0, 1.4), ylim=c(0, 1.4),
	xlab="", ylab="")

top_sq(base_x, base_y, greys[10])
top_sq(base_x+yl[1], base_y+yl[2], greys[6]) # upper right plane
left_sq(base_x, base_y, greys[8])
left_sq(base_x+zl[1], base_y+zl[2], greys[2])
right_sq(base_x+xl[1], base_y+xl[2], greys[6]) # corresponding front plane
right_sq(base_x+xl[1]+yl[1], base_y+xl[2]+yl[2], greys[3])
right_sq(base_x+xl[1]+zl[1], base_y+xl[2]+zl[2], greys[3])
right_sq(base_x+xl[1]+yl[1]+zl[1], base_y+xl[2]+yl[2]+zl[2], greys[6])


text(0.4, 1.0, "X", col="red", cex=1.4)
text(0.5, 0.6, "X", col="red", cex=1.4)

# pal = function(col, border = "light gray", ...)
# {
# n = length(col)
# plot(0, 0, type="n", xlim = c(0, 1), ylim = c(0, 1),
# axes = FALSE, xlab = "", ylab = "", ...)
# rect(0:(n-1)/n, 0, 1:n/n, 1, col = col, border = border)
# }
# 
# pal(sequential_hcl(12, c = 0, power = 2.2))
# 
