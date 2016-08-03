#
# sort-benchmark.R, 16 Jul 16
#
# Data from:
# sortbenchmark.org
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

plot_layout(2, 1)

bench=read.csv(paste0(ESEUR_dir, "benchmark/sort-benchmark.csv.xz"), as.is=TRUE)

brew_col=rainbow(2)

# Daytona is general purpose sort data
minutesort=subset(bench, kind == "Daytona" & benchmark == "MinuteSort")
pennysort=subset(bench, kind == "Daytona" & benchmark == "PennySort")

y_range=range(c(minutesort$perf, pennysort$perf))
x_range=range(c(minutesort$year, pennysort$year))

plot(minutesort$year, minutesort$perf, log="y",
	type="b", col=brew_col[1],
	xlim=x_range, ylim=y_range,
	xlab="Year", ylab="Gigabytes sorted\n")

lines(pennysort$year, pennysort$perf, type="b",col=brew_col[2])

legend(x="topleft", legend=c("Minute sort", "Penny sort"),
		bty="n", fill=brew_col, cex=1.3)



# Data from:
# www.spec.org/cpu2006/results

cpu2006=read.csv(paste0(ESEUR_dir, "benchmark/cpu2006-results-20140206.csv.xz"), as.is=TRUE)

cpu2006$Test.Date=as.Date(paste0("01-", cpu2006$Test.Date), format="%d-%B-%Y")
start_date=as.Date("01-Jan-2006", format="%d-%B-%Y")
cpu2006=subset(cpu2006, Test.Date >= start_date)

cint=subset(cpu2006, Benchmark == "CINT2006")
cint$Benchmark=NULL
cint=subset(cint, Result > 0)


plot(cint$Test.Date, cint$Result,
	col=rgb(0.5, 0.6, 0.4, alpha=0.7),
	xlab="Measurement date", ylab="SPEC2006 int\n")


