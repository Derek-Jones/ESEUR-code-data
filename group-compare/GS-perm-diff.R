#
# GS-perm-diff.R, 29 Aug 16
# Data from:
# The 28:1 {Grant}/{Sackman} legend is misleading, or: {How} large is interpersonal variation really?
# Lutz Prechelt
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")



gs=read.csv(paste0(ESEUR_dir, "developers/grant-sackman.csv.xz"), as.is=TRUE)

algebra=subset(gs, task=="C_algebra")

online=subset(subset(algebra, group == "online"))
offline=subset(subset(algebra, group != "online"))
subj_online=nrow(online)
total_subj=nrow(algebra)
subj_time=c(online$time, offline$time)

subj_mean_diff=mean(online$time)-mean(offline$time)


# Exact permutation test
subj_nums =seq(1:total_subj)
# Generate all possible subject combinations
subj_perms=combn(subj_nums, subj_online)

mean_diff = function(x)
{
# Difference in mean of one subject combination and all other subjects
mean(subj_time[x]) - mean(subj_time[!(subj_nums %in% x)])
}

# Indexing by column iterates through every permutation
perm_res=apply(subj_perms, 2, mean_diff)

# p-value of two-sided test
sum(abs(perm_res) >= abs(subj_mean_diff)) / length(perm_res)

plot(density(perm_res),
	main="", ylab="Density\n")


# Now the bootstrap, which in this case is testing an assumed wider population.

library("boot")

mean_diff=function(bids, indices)
{
t=bids[indices]
return(mean(t[1:subj_online])-mean(t[(subj_online+1):total_subj]))
}

bid_boot=boot(algebra$time, mean_diff, R = 9999)

plot(density(bid_boot$t),
	main="", ylab="Density\n")

mean(bid_boot$t)
sd(bid_boot$t)

length(bid_boot$t[abs(bid_boot$t) >= subj_mean_diff])


