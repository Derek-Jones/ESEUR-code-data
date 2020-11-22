#
# kintsch73.R, 28 Jan 20
# Data from:
# Comprehension and Recall of Text as a Function of Content Variables
# W. Kintsch and E. Kozminsky and W. J. Streby and G. McKoon and J. M. Keenan
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example_experiment reading_example comprehension_example recall_example


source("ESEUR_config.r")


pal_col=rainbow(2)


plot(0, type="n", bty="n",
	xlim=c(0.05, 2.15), ylim=c(0.05, 1.9),
	xaxs="i", yaxs="i",
	xaxt="n", yaxt="n",
	xlab="", ylab="")

off=1.2

text(0, off+0.65, "Romulus, the legendary founder of Rome, took", pos=4)
text(0, off+0.55, "  the women of the Sabine by force.", pos=4)


text(0, off+0.4, "1", pos=4, col=pal_col[1])
text(0, off+0.3, "2", pos=4, col=pal_col[1])
text(0, off+0.2, "3", pos=4, col=pal_col[1])
text(0, off+0.1, "4", pos=4, col=pal_col[1])
text(0.1, off+0.4, "(took, Romulus, women, by force)", pos=4, col=point_col)
text(0.1, off+0.3, "(found, Romulus, Rome)", pos=4, col=point_col)
text(0.1, off+0.2, "(legendary, Romulus)", pos=4, col=point_col)
text(0.1, off+0.1, "(Sabine, women)", pos=4, col=point_col)

text(1.47, off+0.24, "1", col=pal_col[1])

# arrow right 0.15
text(1.5+0.17, off+0.24, "   3", pos=4, col=pal_col[1])
arrows(x0=1.5, y0=off+0.24, x1=1.5+0.25, length=0.05, col=pal_col[2])
text(1.5+0.17, off+0.24+0.15, "   2", pos=4, col=pal_col[1])
arrows(x0=1.5, y0=off+0.24, x1=1.5+0.25, y1=off+0.24+0.15, length=0.05, col=pal_col[2])
text(1.5+0.17, off+0.24-0.15, "   4", pos=4, col=pal_col[1])
arrows(x0=1.5, y0=off+0.24, x1=1.5+0.25, y1=off+0.24-0.12, length=0.05, col=pal_col[2])

text(0, 1.05, "Cleopatra's downfall lay in her foolish trust in the", pos=4)
text(0, 0.95, "  fickle political figures of the Roman world.", pos=4)

text(0, 0.8, "1", pos=4, col=pal_col[1])
text(0, 0.7, "2", pos=4, col=pal_col[1])
text(0, 0.6, "3", pos=4, col=pal_col[1])
text(0, 0.5, "4", pos=4, col=pal_col[1])
text(0, 0.4, "5", pos=4, col=pal_col[1])
text(0, 0.3, "6", pos=4, col=pal_col[1])
text(0, 0.2, "7", pos=4, col=pal_col[1])
text(0, 0.1, "8", pos=4, col=pal_col[1])
text(0.1, 0.8, expression("(because, "*alpha*", "*beta*")"), pos=4, col=point_col)
text(0.1, 0.7, expression(alpha*" "%->%" (fell down, Cleopatra)"), pos=4, col=point_col)
text(0.1, 0.6, expression(beta*" " %->%" (trust, Cleopatra, figures)"), pos=4, col=point_col)
text(0.1, 0.5, "(foolish, trust)", pos=4, col=point_col)
text(0.1, 0.4, "(fickle, figures)", pos=4, col=point_col)
text(0.1, 0.3, "(political, figures)", pos=4, col=point_col)
text(0.1, 0.2, "(part of, figures, world)", pos=4, col=point_col)
text(0.1, 0.1, "(Roman, world)", pos=4, col=point_col)

text(1.3+0.00, 0.45+0.00, "1", col=pal_col[1])
text(1.3+0.20, 0.45+0.00, " 3", pos=4, col=pal_col[1])
arrows(x0=1.35, y0=0.45, x1=1.35+0.20, length=0.05, col=pal_col[2])

text(1.3+0.05+0.40, 0.45+0.00, " 4", pos=4, col=pal_col[1])
arrows(x0=1.35+0.10+0.20, y0=0.45, x1=1.35+0.10+0.2+0.15, length=0.05, col=pal_col[2])
text(1.3+0.20, 0.45+0.15, " 2", pos=4, col=pal_col[1])
arrows(x0=1.35, y0=0.45, x1=1.35+0.20, y=0.45+0.15, length=0.05, col=pal_col[2])

text(1.3+0.05+0.40, 0.45-0.15, " 5", pos=4, col=pal_col[1])
arrows(x0=1.35+0.10+0.20, y0=0.45, x1=1.35+0.10+0.2+0.15, y1=0.45-0.15, length=0.05, col=pal_col[2])
text(1.3+0.10+0.60, 0.45-0.15, " 6", pos=4, col=pal_col[1])
arrows(x0=1.35+0.10+0.45, y0=0.45-0.15, x1=1.35+0.10+0.2+0.40, length=0.05, col=pal_col[2])

text(1.3+0.05+0.40, 0.45-0.30, " 7", pos=4, col=pal_col[1])
arrows(x0=1.35+0.10+0.20, y0=0.45, x1=1.35+0.10+0.2+0.15, y1=0.45-0.30, length=0.05, col=pal_col[2])
text(1.3+0.10+0.60, 0.45-0.30, " 8", pos=4, col=pal_col[1])
arrows(x0=1.35+0.10+0.45, y0=0.45-0.30, x1=1.35+0.10+0.2+0.40, length=0.05, col=pal_col[2])

