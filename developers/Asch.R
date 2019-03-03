#
# Asch.R, 10 Dec 16
# Data from:
# Studies of Independence and Conformity: {A} Minority of One Against a Unanimous Majority, Fig 2
# Solomon E. Asch
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment human social-conformity decision


source("ESEUR_config.r")


plot(0, type="n", bty="n", xaxt="n", yaxt="n", xaxs="i", yaxs="i",
	xlim=c(0.8, 3.2), ylim=c(-1, 26.5),
	xlab="", ylab="")


y_off=0.1

lines(c(1, 1), c(y_off+0, y_off+6.25), col=point_col, lwd=4)
lines(c(2, 2), c(y_off+0, y_off+8.00), col=point_col, lwd=4)
lines(c(3, 3), c(y_off+0, y_off+6.75), col=point_col, lwd=4)
text(1, y_off, "6.25", pos=1)
text(2, y_off, "8.00", pos=1)
text(3, y_off, "6.75", pos=1)

y_off=12

lines(c(1, 1), c(y_off+0, y_off+5.00), col=point_col, lwd=4)
lines(c(2, 2), c(y_off+0, y_off+4.00), col=point_col, lwd=4)
lines(c(3, 3), c(y_off+0, y_off+6.50), col=point_col, lwd=4)
text(1, y_off, "5.00", pos=1)
text(2, y_off, "4.00", pos=1)
text(3, y_off, "6.50", pos=1)

y_off=y_off+10

lines(c(1, 1), c(y_off+0, y_off+3.75), col=point_col, lwd=4)
lines(c(2, 2), c(y_off+0, y_off+4.25), col=point_col, lwd=4)
lines(c(3, 3), c(y_off+0, y_off+3.00), col=point_col, lwd=4)
text(1, y_off, "3.75", pos=1)
text(2, y_off, "4.25", pos=1)
text(3, y_off, "3.00", pos=1)


