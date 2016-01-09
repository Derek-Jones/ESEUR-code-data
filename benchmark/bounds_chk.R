#
# bounds_chk.R, 18 Aug 14
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

library("biglm")


# time,s_l,is_1st,opt,expr,expr_pos

# The following model cannot be built on a machine with 32G of RAM.
# It swaps like mad for hours...
# Building using every 7th row from the dataset finishes reasonable quickly.
# bench=read.csv(paste0(ESEUR_dir, "benchmark/bounds_7_chk.csv.xz"))
# bounds_mod=glm(time ~ s_l+is_1st+opt*expr, data=bench, y=FALSE, model=FALSE)

# Alternatively use the biglm package
bench=read.csv(paste0(ESEUR_dir, "benchmark/bounds_chk.csv.xz"))

bench$time=bench$time/1000000

# Doing a third of the data at a time works for me.
# Smaller chunks may be needed for machines with less than 32G of RAM
data_len=nrow(bench)
data_third=data_len %/% 3

# Build model with first chunk
bounds_mod=biglm(time ~ s_l+is_1st+(opt+expr_pos)*expr, data=bench[1:data_third, ])

# Update model with remaining chunks
bounds_mod=update(bounds_mod, moredata=bench[(data_third+1):(2*data_third), ])
bounds_mod=update(bounds_mod, moredata=bench[(2*data_third+1):data_len, ])

summary(bounds_mod)


