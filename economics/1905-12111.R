#
# 1905-12111.R, 21 Jan 20
# Data from:
# Analyzing and Supporting Adaptation of Online Code Examples
# Tianyi Zhang and Di Yang and Crista Lopes and Miryung Kim
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Stack-Overflow_source-code Github_Stack-Overflow

source("ESEUR_config.r")


pal_col=rainbow(2)

cfreq=read.csv(paste0(ESEUR_dir, "economics/1905-12111.csv.xz"), as.is=TRUE)

plot(cfreq$lines, cfreq$attributed/max(cfreq$attributed, na.rm=TRUE), log="x", col=pal_col[2],
	xlab="Lines", ylab="Occurrences (normalised)\n")

points(cfreq$lines, cfreq$clones/max(cfreq$clones, na.rm=TRUE), col=pal_col[1])

legend(x="topright", legend=c("Clones", "Attributed"), bty="n", fill=pal_col, cex=1.2)

# TODO
# use bootstrap to show same distribution

