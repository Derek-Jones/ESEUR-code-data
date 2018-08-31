#
# 16.R, 30 Aug 18
#
# Data from:
# Taghi Javdani Gandomani and Koh Tieng Wei and Abdulelah Khaled Binhamid
# A Case Study Research on Software Cost Estimation Using Experts? Estimates, Wideband Delphi, and Planning Poker Technique
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG cost-estimation planning-poker delphi experiment


source("ESEUR_config.r")


library("boot")

mean_diff=function()
{
s_ind=rnorm(len_est_2) # random numbers centered on zero
# Randomly assign estimates to each group
expert=c(est_2$expert[s_ind < 0], est_2$planning.poker[s_ind >= 0])
# Sampling with replacement, so two sets of random numbers needed
s_ind=rnorm(len_est_2) # random numbers centered on zero
poker=c(est_2$expert[s_ind < 0], est_2$planning.poker[s_ind >= 0])
# The code for sampling without replacement
# poker=c(est_2$expert[s_ind >= 0], est_2$planning.poker[s_ind < 0])
return(mean(expert)-mean(poker))
}


est_1=read.csv(paste0(ESEUR_dir, "group-compare/16_1.csv.xz"), as.is=TRUE)
est_2=read.csv(paste0(ESEUR_dir, "group-compare/16_2.csv.xz"), as.is=TRUE)

est_mean_diff=abs(mean(est_2$expert)-mean(est_2$planning.poker))
len_est_2=nrow(est_2)

t=replicate(4999, mean_diff()) # Implement our own bootstrap

plot(density(t))

mean(t)
sd(t)

length(t[abs(t) > est_mean_diff]) # How many means this extreme?


# pal_col=rainbow(3)
# 
# plot(est_1$actual.cost, est_1$expert, col=pal_col[1])
# points(est_1$actual.cost, est_1$wideband.Delphi, col=pal_col[2])
# lines(c(20, 120), c(20, 120))
# 
# plot(est_2$actual.cost, est_2$expert, col=pal_col[1])
# points(est_2$actual.cost, est_2$planning.poker, col=pal_col[2])
# lines(c(20, 120), c(20, 120))


