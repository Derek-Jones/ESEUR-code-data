#
# array-durbinwatson.R, 25 May 15
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

library("car")


durbinwatson=function(df)
{
t=glm(time ~ 1, data=df)
df$dw=durbinWatsonTest(t)
return(df)
}


# time,s_l,is_1st,opt,expr,expr_pos

# The following model cannot be built on a machine with 32G of RAM.
# It swaps like mad for hours...
# Building using every 7th row from the dataset finishes reasonable quickly.
# bench=read.csv(paste0(ESEUR_dir, "benchmark/bounds_7_chk.csv.xz"))
# bounds_mod=glm(time ~ s_l+is_1st+opt*expr, data=bench, y=FALSE, model=FALSE)

# Alternatively use the biglm package
bench=read.csv(paste0(ESEUR_dir, "benchmark/bounds_chk.csv.xz"))

bench$time=bench$time/1000000

# dw=ddply(bench, .(opt, expr), durbinwatson)

mk_v0_mod=function(O_str)
{
t1=subset(bench, (is_1st == 0) & (s_l == "L") & (opt == O_str) & (expr == "v0"))

t1_time=t1$time
t1_mod=glm(t1_time ~ 1)

return(t1_mod)
}

to0=mk_v0_mod("o0")
# to3=mk_v0_mod("o3")

dw=durbinWatsonTest(to0)

