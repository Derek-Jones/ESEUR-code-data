#
# sternberg69.R,  6 Jan 17
# Data from:
# Memory-Scanning: {Mental} Processes Revealed by Reaction-Time Experiments
# Saul Sternberg
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)

reaction=read.csv(paste0(ESEUR_dir, "developers/sternberg69.csv.xz"), as.is=TRUE)

plot(reaction$negative, log="y", type="b", col=pal_col[1],
	ylim=c(400, 630),
	xlab="Number of items", ylab="Mean reaction time (msec)\n")
points(reaction$positive, type="b", col=pal_col[2])

legend(x="bottomright", legend=c("Negative", "Positive"), bty="n", fill=pal_col, cex=1.2)

