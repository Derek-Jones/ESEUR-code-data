#
# US-comp-ind.R, 11 Nov 17
# Data from:
# Gerald W. Brock
# The {U.S.} Computer Industry: {A} Study of Market Power
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


dwarves=read.csv(paste0(ESEUR_dir, "ecosystems/US-comp-ind.csv.xz"), as.is=TRUE)

IBM=apply(dwarves[, -1], MARGIN=1,
			function(X) 100-sum(X, na.rm=TRUE))
IBM[dwarves$Year == 1969]=NA

companies=colnames(dwarves[, -1])
pal_col=rainbow(length(companies)+1)

plot(0, type="n",
	xaxs="i", yaxs="i",
	xlim=range(dwarves$Year), ylim=c(0, 80),
	xlab="Year", ylab="Market share (percentage)\n")

dummy=sapply(2:length(companies),
		function(X) lines(dwarves$Year, dwarves[, X], col=pal_col[X]))
lines(dwarves$Year, IBM, col=pal_col[1])

legend(x="right", legend=c("IBM", companies), bty="n", fill=pal_col, cex=1.2)

