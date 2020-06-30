#
# milkorwine.R, 22 Jun 20
# Data from:
# Milk or Wine: {Does} Software Security Improve with Age?
# Andy Ozment and Stuart E. Schechter
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG

source("ESEUR_config.r")


pal_col=rainbow(15)

sc=read.csv(paste0(ESEUR_dir, "projects/milkorwine.csv.xz"), sep="\t", as.is=TRUE)

tsc=t(sc)

# The first, 2.3, release is ten times bigger than the rest.
# It's not displayed so that later releases are better visualized.

plot(1, type="n", log="y",
	xaxt="n",
	xlim=c(2, 15), ylim=c(2e5, 3.0e6)/1e6,
	xlab="Release", ylab="MLOC\n")

axis(1, at=2:15, label=tsc[1, -1])

# lines(tsc[-1, 1])
d=sapply(2:15, function(X) lines(tsc[-1, X]/1e6, col=pal_col[X]))

legend(x="topleft", legend=tsc[1, -1], bty="n", fill=pal_col[-1], cex=1.2,
			inset=c(-0.03, 0))

