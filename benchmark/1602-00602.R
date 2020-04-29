#
# 1602-00602.R,  8 Apr 20
# Data from:
# Virtual Machine Warmup Blows Hot and Cold
# Edd Barrett and Carl Friedrich Bolz-Tereick and Rebecca Killick and Sarah Mount and Laurence Tratt
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG benchmark_jit

source("ESEUR_config.r")


library("jsonlite")


par(mar=MAR_default+c(0.0, 0.7, 0, 0))

pal_col=rainbow(3)

# Data from warmup_results_1_5_linux2_i7_4790.json
# Paper cites:
# https://archive.org/download/softdev warmup experiment artefacts/v0.8/
# But this data is very noisy.
# Data from v1.5 used here (the paper uses a version after v0.8)
t=fromJSON(paste0(ESEUR_dir, "benchmark/1602-00602.csv.xz"))
bt=t[[1]]

plot_run=function(r, col_str)
{
points(bt[r, ], pch=".", col=col_str, cex=2.5)

}

plot(1, pch=".", xaxs="i", cex=2.5,
	xlim=c(1, 2000), ylim=c(0.49, 0.52),
	xlab="Run", ylab="Wall time (seconds)\n\n")
plot_run(24, pal_col[1])
plot_run(25, pal_col[2])
plot_run(3, pal_col[3])

# Consistent autocorrelation across runs:
# par(mfcol=c(4, 5))
# t=sapply(1:20, function(X) pacf(bt[X, ], main=""))

