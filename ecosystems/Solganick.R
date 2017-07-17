#
# Solganick.R, 26 Jun 17
# Data from:
# Software {M\&A} Update
# Solganick & Co.
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

# I have no idea why the original data is not integer
MnA=read.csv(paste0(ESEUR_dir, "ecosystems/Solganick.csv.xz"), as.is=TRUE)

plot(MnA$Year, MnA$Total, type="b", col=point_col,
	ylim=c(0, max(MnA$Total)), yaxs="i",
	xlab="Year", ylab="Software M&A deals\n")

