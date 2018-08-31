#
# SPEC-loess.R, 26 Aug 18
#
# Data from:
# www.spec.org/cpu2006/results
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG SPEC benchmark


source("ESEUR_config.r")


pal_col=rainbow(2)


cpu2006=read.csv(paste0(ESEUR_dir, "benchmark/cpu2006-results-20140206.csv.xz"), as.is=TRUE)

start_date=as.Date("01-Jan-2006", format="%d-%B-%Y")
cpu2006$Test.Date=as.Date(paste0("01-", cpu2006$Test.Date), format="%d-%B-%Y")
cpu2006=subset(cpu2006, Test.Date >= start_date)

cint=subset(cpu2006, Benchmark == "CINT2006")
cint=subset(cint, Result > 0)

res_tab=as.data.frame(table(cint$Result))
res_tab$Var1=as.numeric(res_tab$Var1)

plot(res_tab$Var1, res_tab$Freq, col=pal_col[2],
	xlab="SPECint result", ylab="Number of computers\n")

lines(loess.smooth(res_tab$Var1, res_tab$Freq, span=0.3), col=pal_col[1])

# scatter.smooth(res_tab$Var1, res_tab$Freq, span=0.3, col=point_col,
# 	xlab="SPECint Result", ylab="Number of computers\n")


