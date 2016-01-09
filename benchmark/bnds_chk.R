#
# bnds_chk.R, 18 Aug 14
#
# Data from:
# A Case study of Performance Degradation Attributable to Run-Time Bounds Checks on {C++} Vector Access
# David Flater and William F. Guthrie
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


# time,s_l,is_1st,opt,expr,expr_pos
# small/large iteration count, is-1st, optimization, expression, expression position in sequence of runs
bench=read.csv(paste0(ESEUR_dir, "benchmark/bounds_chk.csv.xz"), as.is=TRUE)

expr=subset(bench, expr == "v0")

bounds_mod_0=glm(time ~ (s_l+is_1st+opt+expr_pos)^2-s_l:is_1st, data=expr)
#bounds_mod_0=glm(time ~ (s_l+is_1st+opt)^2+is_1st:exp_pos, data=expr)

summary(bounds_mod_0)


expr=subset(bench, expr == "v1")

bounds_mod_1=glm(time ~ (s_l+is_1st+opt+expr_pos)^2-s_l:is_1st, data=expr)

summary(bounds_mod_1)

# Repeat, or parameterise, for v2..v12


