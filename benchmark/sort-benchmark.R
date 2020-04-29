#
# sort-benchmark.R,  6 Apr 20
#
# Data from:
# sortbenchmark.org
# www.spec.org/cpu2006/results
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG benchmark_SPEC benchmark_sorting


source("ESEUR_config.r")


plot_layout(2, 1)

pal_col=rainbow(2)

bench=read.csv(paste0(ESEUR_dir, "benchmark/sort-benchmark.csv.xz"), as.is=TRUE)

# Daytona is general purpose sort data
minutesort=subset(bench, kind == "Daytona" & benchmark == "MinuteSort")
pennysort=subset(bench, kind == "Daytona" & benchmark == "PennySort")

y_range=range(c(minutesort$perf, pennysort$perf))
x_range=range(c(minutesort$year, pennysort$year))

plot(minutesort$year, minutesort$perf, log="y",
	type="b", col=pal_col[1],
	xlim=x_range, ylim=y_range,
	xlab="Year", ylab="Gigabytes sorted\n")

lines(pennysort$year, pennysort$perf, type="b",col=pal_col[2])

legend(x="topleft", legend=c("Minute sort", "Penny sort"),
		bty="n", fill=pal_col, cex=1.2)



# Data from:
# www.spec.org/cpu2006/results

cpu2006=read.csv(paste0(ESEUR_dir, "benchmark/cpu2006-results-20140206.csv.xz"), as.is=TRUE)

cpu2006$Test.Date=as.Date(paste0("01-", cpu2006$Test.Date), format="%d-%B-%Y")
start_date=as.Date("01-Jan-2006", format="%d-%B-%Y")
cpu2006=subset(cpu2006, Test.Date >= start_date)

cint=subset(cpu2006, Benchmark == "CINT2006")
cint$Benchmark=NULL
cint=subset(cint, Result > 0)


plot(cint$Test.Date, cint$Result, col=pal_col[2],
	xlab="Measurement date", ylab="SPEC2006 int\n")

lines(loess.smooth(cint$Test.Date, cint$Result, span=0.3), col=pal_col[1])

