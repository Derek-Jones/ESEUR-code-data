#
# video-game-exp.R,  3 Feb 18
# Data from:
# Wikipedia: List of most expensive video games to develop
# (costing $50 or more)
# downloaded January 2018
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


vg=read.csv(paste0(ESEUR_dir, "economics/video-game-exp.csv.xz"), as.is=TRUE)

plot(vg$Year, vg$Total.cost.with.2018.inflation, log="y", col=point_col,
	xlab="Year", ylab="Total cost (adjusted to 2018 $million)\n")

