#
# bnds_chk.R, 18 Jul 18
#
# Data from:
# A Case study of Performance Degradation Attributable to Run-Time Bounds Checks on {C++} Vector Access
# David Flater and William F. Guthrie
#
# Example from:
# Evidence-based Software Engineering using R
# Derek M. Jones
#
# TAG C++ performance array runtime check


source("ESEUR_config.r")


# time,s_l,is_1st,opt,expr,expr_pos
# small/large iteration count, is-1st, optimization, expression, expression position in sequence of runs
bench=read.csv(paste0(ESEUR_dir, "benchmark/bounds_chk.csv.xz"), as.is=TRUE)

expr_v0=subset(bench, expr == "v0")

bounds_mod_0=glm(time ~ (s_l+is_1st+opt+expr_pos)^2-s_l:is_1st, data=expr_v0)
#bounds_mod_0=glm(time ~ (s_l+is_1st+opt)^2+is_1st:exp_pos, data=expr_v0)

summary(bounds_mod_0)


expr_v1=subset(bench, expr == "v1")

bounds_mod_1=glm(time ~ (s_l+is_1st+opt+expr_pos)^2-s_l:is_1st, data=expr_v1)

summary(bounds_mod_1)

# Repeat, or parameterise, for v2..v12

# A 64G machine is not big enough to handle _all
# Error: cannot allocate vector of size 42.1 Gb
# bounds_mod_all=glm(time ~ (expr+s_l+is_1st+opt+expr_pos)^2-s_l:is_1st, data=bench)
#
# summary(bounds_mod_all)

expr_v012=subset(bench, expr == "v0" | expr == "v1" | expr == "v2")

bounds_mod_012=glm(time ~ (expr+s_l+is_1st+opt+expr_pos)^2-s_l:is_1st, data=expr_v012)

summary(bounds_mod_012)

# Repeat, or parameterise, for v2..v12

