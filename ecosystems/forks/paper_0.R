#
# paper_0.R,  5 Jun 17
# Data from:
# A Comprehensive Study of Software Forks: {Dates}, Reasons and Outcomes
# Gregorio Robles and Jes\'{u}s M.  Gonz\'{a}lez-Barahona
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


forks=read.csv(paste0(ESEUR_dir, "ecosystems/forks/paper_0.csv.xz"), as.is=TRUE)

plot(table(forks$Year), type="b", col=point_col,
	xlab="Year", ylab="Forks")

