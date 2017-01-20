#
# berlin69.R, 12 Dec 16
# Data from:
# Basic Color Terms: {Their} Universality and Evolution
# Brent Berlin and Paul Kay
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot(0, type="n", bty="n", xaxt="n", yaxt="n", xaxs="i", yaxs="i",
	xlim=c(0.2, 3.2), ylim=c(0.8, 11.7),
	xlab="", ylab="")

text(1, 11.3, "Purple", col="purple", cex=1.3)
text(3, 11.3, "Pink", col="pink", cex=1.3)

text(1, 10.7, "Orange", col="orange", cex=1.3)
text(3, 10.7, "Grey", col="grey", cex=1.3)
lines(c(2, 1.5), c(10.5, 9.7), col=point_col)
lines(c(2, 2.5), c(10.5, 9.7), col=point_col)

text(2, 9, "Brown", col="brown", cex=1.3)
lines(c(2, 1.5), c(8.5, 7.7), col=point_col)
lines(c(2, 2.5), c(8.5, 7.7), col=point_col)


text(2, 7, "Blue", col="blue", cex=1.3)
lines(c(2, 1.5), c(6.5, 5.7), col=point_col)
lines(c(2, 2.5), c(6.5, 5.7), col=point_col)


text(1, 5, "Green", col="green", cex=1.3)
text(3, 5, "Yellow", col="yellow", cex=1.3)
lines(c(2, 1.5), c(4.5, 3.7), col=point_col)
lines(c(2, 2.5), c(4.5, 3.7), col=point_col)


text(2, 3, "Red", col="red", cex=1.3)
lines(c(2, 1.5), c(2.5, 1.7), col=point_col)
lines(c(2, 2.5), c(2.5, 1.7), col=point_col)


text(1, 1, "Black", cex=1.3)
polygon(c(2.79, 3.3, 3.3, 2.79, 2.79), 
	c(0.75, 0.75, 1.25, 1.25, 0.75), col="black")
text(3, 1, "White", col="white", cex=1.3)


