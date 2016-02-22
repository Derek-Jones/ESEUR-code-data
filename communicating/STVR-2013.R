#
# STVR-2013.csv, 31 Jan 16
#
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("lattice")
library("latticeExtra")
library("reshape2")


STVR=read.csv(paste0(ESEUR_dir, "communicating/STVR-2013.csv"), as.is=TRUE)


STVR_col=melt(STVR, id.vars="fault", variable.name="fix", value.name="occurrences")
STVR_col$fault=as.factor(STVR_col$fault)
# fix is melt'ed as a factor (I know not why)
# STVR_col$fix=as.character(STVR_col$fix)

# log transform to pull out small differences in majority of counts
transform_breaks= exp(do.breaks(range(log(1e-4+STVR_col$occurrences)), 20))
t=cloud(occurrences ~ fix+fault, STVR_col, panel.3d.cloud=panel.3dbars,
		xlab="Fixes involved", ylab="Fault found", zlab="Count",
		xbase=0.5, ybase=0.5, aspect=c(1, 1),
                col.facet = level.colors(STVR_col$occurrences,
				    at = transform_breaks,
                                    col.regions = rainbow),
# An exercise in suck it and see
#		screen=list(x=-50, y=60, z=40),
		scales=list(arrows=FALSE,
				distance=c(2, 1.1, 1),
# Rotate tick labels
				x=list(rot=-20)
			))

plot(t)

