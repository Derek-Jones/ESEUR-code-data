#
# NASA_gruhl.R,  4 Mar 20
#
# Data from:
# Lessons Learned cost/schedule assessment guide
# Werner Gruhl
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG estimate_NASA project_investment


source("ESEUR_config.r")


pal_col=rainbow(3)


gruhl=read.csv(paste0(ESEUR_dir, "regression/NASA_gruhl.csv.xz"), as.is=TRUE)

plot(gruhl$definition.ratio, gruhl$target.overrun, col=pal_col[2],
	xaxs="i", yaxs="i",
	xlim=c(0, max(gruhl$definition.ratio)), ylim=c(0, max(gruhl$target.overrun)),
	xlab="Project definition investment", ylab="Cost overrun\n")

lines(loess.smooth(gruhl$definition.ratio, gruhl$target.overrun, span=0.5), col=pal_col[3])

# Values done by eye
arrows(3.3, 130, 2.6, 150, col=pal_col[1])

