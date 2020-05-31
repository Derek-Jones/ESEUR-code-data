#
# paper_0.R, 22 May 20
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


forks=read.csv(paste0(ESEUR_dir, "ecosystems/forks/paper_0.csv.xz"), as.is=TRUE)

plot(table(forks$Year), type="b", col=point_col,
	yaxs="i",
	xlab="Year", ylab="Forks")

