#
# paper_0.R,  2 Jul 20
# Data from:
# A Comprehensive Study of Software Forks: {Dates}, Reasons and Outcomes
# Gregorio Robles and Jes\'{u}s M.  Gonz\'{a}lez-Barahona
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG project_forks


source("ESEUR_config.r")


library("plyr")


forks=read.csv(paste0(ESEUR_dir, "ecosystems/forks/paper_0.csv.xz"), as.is=TRUE)

f_year=count(forks$Year)

plot(f_year, type="b", col=point_col,
	xaxs="i", yaxs="i",
	ylim=c(0, 24),
	xlab="Year", ylab="Forks")

