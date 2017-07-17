#
# Fleming_Wallace.R, 25 May 17
# Data from:
# Philip J. Fleming and John J. Wallace
# How Not to Lie With Statistics: {The} Correct Way to Summarize Benchmark Results
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("ascii")


bench=read.csv(paste0(ESEUR_dir, "benchmark/Fleming_Wallace.csv.xz"), as.is=TRUE)

rownames(bench)=bench$Prog
bench$Prog=NULL

bench$"R/M"=bench$R/bench$M
bench$"M/M"=bench$M/bench$M
bench$"Z/M"=bench$Z/bench$M

bench$"R/R"=bench$R/bench$R
bench$"M/R"=bench$M/bench$R
bench$"Z/R"=bench$Z/bench$R

arithmean=colMeans(bench)
geomean=apply(bench, 2, prod)^(1/nrow(bench))

bench=rbind(bench, Arithmetic=arithmean,
		   Geometric=geomean)

print(ascii(bench, include.rownames=TRUE, digits=2,
        align="r", frame="topbot", grid="none"))

