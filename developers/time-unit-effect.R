#
# time-unit-effect.R, 17 Aug 20
# Data from:
# Unit effects in software project effort estimation: {Work}-hours gives lower effort estimates than workdays
# Magne J{\o}rgensen
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human estimate_units

source("ESEUR_config.r")


boot_mean_diff=function(sys_x)
{
s_wh=sample(1:total_est, num_wh, replace=TRUE)
s_wd=sample(1:total_est, num_wd, replace=TRUE)
return(mean(sys_x[s_wd])-mean(sys_x[s_wh]))
}



tu=read.csv(paste0(ESEUR_dir, "developers/time-unit-effect.csv.xz"), as.is=TRUE, sep="\t")

wh=subset(tu, UnitGroup == "WH")
wd=subset(tu, UnitGroup == "WD")

# Estimates in hours
num_wh=nrow(wh)
# Estimates in days, converted to hours
num_wd=nrow(wd)
total_est=num_wh+num_wd


sys1_md=replicate(9999, boot_mean_diff(tu$System1))

# Percentage of cases where the mean difference is larger than actual
100*length(which(sys1_md > (mean(wd$System1)-mean(wh$System1))))/9999
#
# 1.05

sys2_md=replicate(9999, boot_mean_diff(tu$System2))

# Percentage of cases where the mean difference is larger than actual
100*length(which(sys2_md > (mean(wd$System2)-mean(wh$System2))))/9999
#
# 0.41

con_mod=glm(System1 ~ Conversion, data=wd)
summary(con_mod)


table(tu$Conversion)
#
#  6 6.5   7 7.5   8 
#  7   3  11   2  13 

# Are there any 'day' length effects in the hour estimates?
table(wh$System1/8-trunc(wh$System1/8))
#
#     0  0.125   0.25  0.375    0.5 0.5625  0.625   0.75  0.875 
#     8      2      6      3      8      1      4      3      3 

table(wh$System2/8-trunc(wh$System2/8))
#
#    0 0.125  0.25 0.375   0.5 0.625  0.75 0.875 
#    7     3     4     1    10     3     8     2 

