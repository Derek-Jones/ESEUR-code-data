#
# robinson1976a.R, 10 Nov 16
# Data from:
# Fashions in Shaving and Trimming of the Beard: {The} Men of the {Illustrated London News}, 1842-1972
# Dwight E. Robinson
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(3)

hair=read.csv(paste0(ESEUR_dir, "evolution/robinson1976a.csv.xz"), as.is=TRUE)
hair$total=rowSums(hair[ , -1])

plot(hair$year, 100*hair$clean_shaven/hair$total, type="l", col=pal_col[1],
	xlab="Year", ylab="Percentage\n")
lines(loess.smooth(hair$year, 100*hair$beard/hair$total, span=0.1), col=pal_col[2])
lines(loess.smooth(hair$year, 100*hair$mustache/hair$total, span=0.1), col=pal_col[3])

legend(x="topleft", legend=c("Clean shaven", "Beard", "Mustache"), bty="n", fill=pal_col, cex=1.2)

