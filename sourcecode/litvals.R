#
# litvals.R, 24 Apr 18
# Data from:
#
# The New C Standard
# Derek M. Jones
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)


int_lit=read.csv(paste0(ESEUR_dir, "sourcecode/intlitvals.csv.xz"), as.is=TRUE)
hex_lit=read.csv(paste0(ESEUR_dir, "sourcecode/hexlitvals.csv.xz"), as.is=TRUE)

plot(int_lit$value, int_lit$occurrences, log="xy", col=pal_col[1],
	xlab="Numeric value", ylab="Occurrences\n",
	xlim=c(1, 1024))

points(hex_lit$value, hex_lit$occurrences, col=pal_col[2])

legend(x="topright", legend=c("Decimal", "Hexadecimal"),
			bty="n", fill=pal_col, cex=1.2)

