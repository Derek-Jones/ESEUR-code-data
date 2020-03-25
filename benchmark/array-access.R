#
# array-access.R, 16 Jul 16
#
# Data from:
#
# A Case study of Performance Degradation Attributable to Run-Time Bounds Checks on {C++} Vector Access
# David Flater and William F. Guthrie
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG benchmark_C++ C++_array-access


source("ESEUR_config.r")


plot_layout(2, 1, max_height=8.5, default_width=5)
par(mar=MAR_default-c(0.6, 0, 0.8, 0))

pal_col=rainbow(3)

# time,s_l,is_1st,opt,expr,expr_pos

# The following model cannot be built on a machine with 32G of RAM.
# It swaps like mad for hours...
# Building using every 7th row from the dataset finishes reasonable quickly.
# bench=read.csv(paste0(ESEUR_dir, "benchmark/bounds_7_chk.csv.xz"))
# bounds_mod=glm(time ~ s_l+is_1st+opt*expr, data=bench, y=FALSE, model=FALSE)

# Alternatively use the biglm package
# bench=read.csv(paste0(ESEUR_dir, "benchmark/bounds_chk.csv.xz"))
bench=read.csv(paste0(ESEUR_dir, "benchmark/bounds_7_chk.csv.xz"))

bench$time=bench$time/1000000

v0_cell=function(O_str)
{
t1=subset(bench, (is_1st == 0) & (s_l == "L") & (opt == O_str) & (expr == "v0"))

return(t1)
}


to0=v0_cell("o0")
plot(to0$time, col=point_col, cex.axis=1.5, cex.lab=1.5,
	xaxs="i",
	xlab="Successive measurements", ylab="Time\n")
to3=v0_cell("o3")
plot(to3$time, col=point_col, cex.axis=1.5, cex.lab=1.5,
	xaxs="i",
	xlab="Successive measurements", ylab="Time\n")

