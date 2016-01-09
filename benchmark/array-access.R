#
# array-access.R, 27 Dec 15
#
# Data from:
#
# A Case study of Performance Degradation Attributable to Run-Time Bounds Checks on {C++} Vector Access
# David Flater and William F. Guthrie
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


pal_col=rainbow(3)

# time,s_l,is_1st,opt,expr,expr_pos

# The following model cannot be built on a machine with 32G of RAM.
# It swaps like mad for hours...
# Building using every 7th row from the dataset finishes reasonable quickly.
# bench=read.csv(paste0(ESEUR_dir, "benchmark/bounds_7_chk.csv.xz"))
# bounds_mod=glm(time ~ s_l+is_1st+opt*expr, data=bench, y=FALSE, model=FALSE)

# Alternatively use the biglm package
bench=read.csv(paste0(ESEUR_dir, "benchmark/bounds_chk.csv.xz"))

bench$time=bench$time/1000000

v0_cell=function(O_str)
{
t1=subset(bench, (is_1st == 0) & (s_l == "L") & (opt == O_str) & (expr == "v0"))

return(t1)
}

plot_layout(1, 2)

to0=v0_cell("o0")
plot(to0$time, col=point_col,
	xlab="Successive measurements", ylab="Time\n")
to3=v0_cell("o3")
plot(to3$time, col=point_col,
	xlab="Successive measurements", ylab="Time\n")

