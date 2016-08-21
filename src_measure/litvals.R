#
# litvals.R,  8 Jan 16
#
# Data from:
#
# The New C Standard
# Derek M. Jones
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


int_lit=read.csv(paste0(ESEUR_dir, "src_measure/intlitvals.csv.xz"), as.is=TRUE)
hex_lit=read.csv(paste0(ESEUR_dir, "src_measure/hexlitvals.csv.xz"), as.is=TRUE)

pal_col=rainbow(2)

plot(int_lit$value, int_lit$occurrences, log="xy", col=pal_col[1],
	xlab="Literal value", ylab="Occurrences\n",
	xlim=c(1, 1024))

points(hex_lit$value, hex_lit$occurrences, col=pal_col[2])

legend(x="topright", legend=c("Decimal", "Hexadecimal"),
			bty="n", fill=pal_col, cex=1.2)

