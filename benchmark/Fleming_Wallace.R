#
# Fleming_Wallace.R, 16 Nov 18
# Data from:
# Philip J. Fleming and John J. Wallace
# How Not to Lie With Statistics: {The} Correct Way to Summarize Benchmark Results
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG benchmark statistics


source("ESEUR_config.r")


library("ascii")


bench=read.csv(paste0(ESEUR_dir, "benchmark/Fleming_Wallace.csv.xz"), as.is=TRUE)

rownames(bench)=bench$Prog
bench$Prog=NULL

bench$"R/M"=bench$R/bench$M
bench$"M/R"=bench$M/bench$R

bench$"R/Z"=bench$R/bench$Z
bench$"Z/R"=bench$Z/bench$R

bench$"M/Z"=bench$M/bench$Z
bench$"Z/M"=bench$Z/bench$M


arithmean=colMeans(bench)
geomean=apply(bench, 2, prod)^(1/nrow(bench))

bench=rbind(bench, Arithmetic=arithmean,
		   Geometric=geomean)

print(ascii(bench, include.rownames=TRUE, digits=2,
        align="r", frame="topbot", grid="none"))

