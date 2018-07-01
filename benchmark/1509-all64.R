#
# 1509-all64.R, 28 May 18
# Data from:
# Array Layouts for Comparison-Based Searching
# Paul-Virak Khuong and Pat Morin
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


# library("dplyr")


pal_col=rainbow(5)


plot_run=function(df, col_str="black")
{
lines(df$items, df$seconds, col=col_str)
}


all64=read.csv(paste0(ESEUR_dir, "benchmark/1509-all64.csv.xz"), as.is=TRUE)


plot(0, type="n", log="xy",
	xaxs="i", yaxs="i",
	xlim=range(all64$items), ylim=range(all64$seconds),
	xlab="Array size", ylab="Runtime (secs)\n")

# d_ply(all64, .(alg), plot_run)

plot_run(subset(all64, alg == "eytzinger_bf"), pal_col[1])
plot_run(subset(all64, alg == "eytzinger_branchy"), pal_col[2])
plot_run(subset(all64, alg == "sorted_bfp"), pal_col[3])
plot_run(subset(all64, alg == "btree16_bf_a"), pal_col[4])
plot_run(subset(all64, alg == "btree32_a"), pal_col[5])


# Sizes of L1, L2, and L3 cache
lines(c(2^13, 2^13), c(1e-3, 2), col="grey")
text(2^13, 1, "L1")
lines(c(2^16, 2^16), c(1e-3, 2), col="grey")
text(2^16, 1, "L2")
lines(c(2^21, 2^21), c(1e-3, 2), col="grey")
text(2^21, 1, "L3")

