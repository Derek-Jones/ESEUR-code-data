#
# STVR-2013.csv, 22 Aug 18
# Exploring the missing link: an empirical study of software fixes
# Maggie Hamill and Katerina Goseva-Popstojanova
#
# Data from:
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG fault fault-fixe integration design code requirements


source("ESEUR_config.r")

library("lattice")
library("latticeExtra")
library("reshape2")


STVR=read.csv(paste0(ESEUR_dir, "communicating/STVR-2013.csv.xz"), as.is=TRUE)


STVR_col=melt(STVR, id.vars="fault", variable.name="fix", value.name="occurrences")
STVR_col$fault=as.factor(STVR_col$fault)
# fix is melt'ed as a factor (I know not why)
# STVR_col$fix=as.character(STVR_col$fix)

# log transform to pull out small differences in majority of counts
transform_breaks= exp(do.breaks(range(log(1e-4+STVR_col$occurrences)), 20))
t=cloud(occurrences ~ fix+fault, STVR_col, panel.3d.cloud=panel.3dbars,
		xlab="Fixes involved", ylab="Fault location         ", zlab="\nCount",
		xbase=0.5, ybase=0.5, aspect=c(1, 1),
		cex=1.3,
# Makes the outer box transparent (for some reason)
		par.settings=list(axis.line=list(col="transparent")),
                col.facet = level.colors(STVR_col$occurrences,
				    at = transform_breaks,
                                    col.regions = rainbow),
# An exercise in suck it and see
#		screen=list(x=-50, y=60, z=40),
		scales=list(arrows=FALSE,
				distance=c(2, 1.1, 1),
# Rotate tick labels
				x=list(rot=-40, cex=0.9),
				y=list(cex=1.0),
				z=list(cex=1.0)
			))

plot(t)

