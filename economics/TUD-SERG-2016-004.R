#
# TUD-SERG-2016-004.R, 18 Mar 17
# Data from:
# Do Estimators Learn? {On} the Effect of a Positively Skewed Distribution of Effort Data on Software Portfolio Productivity
# Hennie Huijgens and Frank Vogelezang
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)

est=read.csv(paste0(ESEUR_dir, "economics/TUD-SERG-2016-004.csv.xz"), as.is=TRUE)

est$seq=1:nrow(est)

major_rel=subset(est, trunc(Release) == Release)
minor_rel=subset(est, trunc(Release) != Release)

plot(est$seq, est$Actual_Effort/est$Planned_Effort, type="l", col="grey",
	xlim=c(1, nrow(est)), ylim=c(min(est$Actual_Effort/est$Planned_Effort),
				     max(est$Actual_Effort/est$Planned_Effort)),
	xlab="Release", ylab="Actual/Planned effort\n")
points(major_rel$seq, major_rel$Actual_Effort/major_rel$Planned_Effort, col=pal_col[1])
points(minor_rel$seq, minor_rel$Actual_Effort/minor_rel$Planned_Effort, col=pal_col[2])

legend(x="topright", legend=c("Major releases", "Point releases"), bty="n", fill=pal_col, cex=1.2)

