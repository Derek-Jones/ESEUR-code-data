#
# NASA_gruhl.R,  3 Aug 16
#
# Data from:
# Lessons Learned cost/schedule assessment guide
# Werner Gruhl
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


gruhl=read.csv(paste0(ESEUR_dir, "regression/NASA_gruhl.csv.xz"), as.is=TRUE)

plot(gruhl$definition.ratio, gruhl$target.overrun, col=point_col,
	xlab="Project definition investment", ylab="Cost overrun\n")

lines(loess.smooth(gruhl$definition.ratio, gruhl$target.overrun, span=0.5), col="green")

# Values done by eye
arrows(3.3, 130, 2.6, 150, col="red")

