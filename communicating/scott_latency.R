#
# scott_latency.R, 13 Oct 16
# Data from:
# Numbers Every Programmer Should Know
# Colin Scott
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(4)
par(fin=c(2.2, 5.6))


waffle_pt=function(y, width, height, plus_one, line_str, col_str, next_col=0)
{
x_pts=seq(1, width)

dummy=sapply(0:(height-1), function(X)
		points(x_pts, rep(y-X, width), pch=15, cex=0.9, col=col_str))
if (plus_one)
   points(1, y-height, pch=15, cex=0.9, col=col_str)
text(width+0.75, ceiling(y-height/2), line_str, pos=4, cex=0.92)
if (next_col != 0)
   points(width+5+nchar(line_str)/3, ceiling(y-height/2), pch=15, col=next_col)
}

MAX_y=100
b_sep=2

plot(0, type="n", bty="n", xaxt="n", yaxt="n",
	xlab="", ylab="",
	xlim=c(1, 27), ylim=c(1, MAX_y))

waffle_pt(MAX_y, 1, 1, FALSE, "L1 cache reference, 1 ns", pal_col[1])
waffle_pt(MAX_y-1*b_sep, 2, 1, TRUE, "Branch mispredict", pal_col[1])
waffle_pt(MAX_y-2*b_sep-1-1, 2, 2, FALSE, "L2 cache reference", pal_col[1])
waffle_pt(MAX_y-3*b_sep-1-1-2, 4, 4, TRUE, "Mutex lock/unlock", pal_col[1])
waffle_pt(MAX_y-4*b_sep-1-1-2-4, 10, 10, FALSE, "100 ns =  ", pal_col[1], pal_col[2])

MAX_y_2=MAX_y-5*b_sep-1-1-2-4-10

waffle_pt(MAX_y_2-0*b_sep, 1, 1, FALSE, "Main memory reference", pal_col[2])
waffle_pt(MAX_y_2-1*b_sep-1, 2, 1, FALSE, "Send 2K bytes over commodity network", pal_col[2])
waffle_pt(MAX_y_2-2*b_sep-1-1, 5, 4, FALSE, "Compress 1K bytes with Zippy", pal_col[2])
waffle_pt(MAX_y_2-3*b_sep-1-1-4, 10, 10, FALSE, 
	expression(paste("10,000 ns = 10 ", mu, "s =")), pal_col[2], pal_col[3])

MAX_y_3=MAX_y_2-4*b_sep-1-1-4-10

waffle_pt(MAX_y_3-0*b_sep, 1, 1, FALSE, "Read 1 MB sequentially from memory", pal_col[3])
waffle_pt(MAX_y_3-1*b_sep-1, 2, 1, FALSE, "SSD random read", pal_col[3])
waffle_pt(MAX_y_3-2*b_sep-1-1, 7, 7, TRUE, "Round trip within same\ndatacenter", pal_col[3])
waffle_pt(MAX_y_3-3*b_sep-1-1-7, 10, 10, FALSE, "1,000,000 ns = 1 ms =                 ", pal_col[3], pal_col[4])

MAX_y_4=MAX_y_3-4*b_sep-1-1-7-10

waffle_pt(MAX_y_4-0*b_sep, 1, 1, FALSE, "Read 1 MB sequentially from disk", pal_col[4])
waffle_pt(MAX_y_4-1*b_sep, 3, 1, FALSE, "Magnetic disk seek", pal_col[4])
waffle_pt(MAX_y_4-2*b_sep-1-1, 10, 15, FALSE, "Send packet\nCA->Netherlands->CA", pal_col[4])

