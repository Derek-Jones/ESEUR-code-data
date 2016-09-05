#
# SPEC-den-interval.R, 29 Aug 16
#
# Data from:
# www.spec.org/cpu2006/results
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("sm")

cpu2006=read.csv(paste0(ESEUR_dir, "benchmark/cpu2006-results-20140206.csv.xz"), as.is=TRUE)

start_date=as.Date("01-Jan-2006", format="%d-%B-%Y")
cpu2006$Test.Date=as.Date(paste0("01-", cpu2006$Test.Date), format="%d-%B-%Y")
cpu2006=subset(cpu2006, Test.Date >= start_date)

cint=subset(cpu2006, Benchmark == "CINT2006")
cint$Benchmark=NULL
cint=subset(cint, Result > 0)

res_sample=sample(cint$Result, size=1000)

sm.density(res_sample, h=4, col=point_col, display="se",
	rugplot=FALSE,
	ylim=c(0, 0.03),
	xlab="SPECint Result", ylab="Density\n")


