#
# didcomputertech.R, 16 Sep 17
# Data from:
# Did Computer Technology Diffuse Quickly?: {Best} and Average Practice in Mainframe Computers, 1968-1983
# Shane Greenstein
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


mean_age=function(X)
{
return(sum(X*(bench$Age+0.5))/sum(X))
}


bench=read.csv(paste0(ESEUR_dir, "ecosystems/didcomputertech.csv.xz"), as.is=TRUE)

t=apply(bench[, -1], 2, mean_age)

plot(1968:1983, t, type="b", col=point_col,
	xlab="Year", ylab="Age (years)\n")

