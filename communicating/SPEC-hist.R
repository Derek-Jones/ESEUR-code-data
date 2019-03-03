#
# SPEC-hist.R,  2 Mar 19
#
# Data from:
# www.spec.org/cpu2006/results
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG SPEC computer benchmark


source("ESEUR_config.r")

# Need to get this plot to fit in the margin, along with the plot before it
plot_layout(2, 1, max_height=12)
par(mar=MAR_default-c(0.8, 0, 0, 0))


cpu2006=read.csv(paste0(ESEUR_dir, "benchmark/cpu2006-results-20140206.csv.xz"), as.is=TRUE)

start_date=as.Date("01-Jan-2006", format="%d-%B-%Y")
cpu2006$Test.Date=as.Date(paste0("01-", cpu2006$Test.Date), format="%d-%B-%Y")
cpu2006=subset(cpu2006, Test.Date >= start_date)

cint=subset(cpu2006, Benchmark == "CINT2006")
cint$Benchmark=NULL
cint=subset(cint, Result > 0)


hist(cint$Result, main="", col=point_col,
	cex.axis=1.4, cex.lab=1.4,
	xlab="SPECint result", ylab="Number of computers\n")

plot(density(cint$Result), col=point_col, main="",
	cex.axis=1.4, cex.lab=1.4,
	yaxs="i",
	xlab="SPECint result", ylab="Density (of number of computers)\n")


