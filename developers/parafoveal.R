#
# parafoveal.R,  4 Dec 16
# Data from:
# Parafoveal processing in reading, Fig 1
# Elizabeth R. Schotter and Bernhard Angele and Keith Rayner
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot(0, type="n", bty="n", xaxt="n", yaxt="n", xaxs="i",
	xlim=c(1, 45), ylim=c(0, 1),
	xlab="", ylab="")

text(23.5, 0, "The quick brown fox jumped over the lazy dog.",
		family="mono", font=2, cex=1)

text(18.5, 1, "Peripheral", cex=1.1)
text(18.5, 0.9, "Parafoveal", cex=1.1)
text(18.5, 0.73, "Foveal", cex=1.1)

base_poly=0.03

polygon(c(1, 3, 14),
	c(base_poly, base_poly, 1), border="grey", col="grey")

polygon(c(3, 15, 14.5),
	c(base_poly, base_poly, 0.9), border=point_col, col=point_col)

polygon(c(15, 22, 18.5),
	c(base_poly, base_poly, 0.7), border="yellow", col="yellow")

polygon(c(22, 33, 22.5),
	c(base_poly, base_poly, 0.9), border=point_col, col=point_col)

polygon(c(33, 45, 23),
	c(base_poly, base_poly, 1), border="grey", col="grey")


