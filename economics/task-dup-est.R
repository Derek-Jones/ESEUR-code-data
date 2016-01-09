#
# task-dup-est.R, 22 Dec 15
#
# Data from:
# Inconsistency of Expert Judgment-based Estimates of Software Development Effort
# Stein Grimstad and Magne J{\o}rgensen
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library(plyr)


percent_diff=function(df)
{
# print(c(df[1, ]-df[2, ]))
# print(colMeans(df))
percent=100*(df[1, ]-df[2, ])/colMeans(df)
}


plot_s=function(subj, col_num)
{
lines(subj, type="b", col=pal_col[col_num])
}


# First 6 entries are first estimate, second 6 the second estimate
t_est=read.csv(paste0(ESEUR_dir, "economics/task-dup-est.csv.xz"), as.is=TRUE)

perc=ddply(t_est, .(id), percent_diff)

pal_col=rainbow(7)

plot(1:7, type="n",
	xlab="Estimate number", ylab="Percent relative change\n",
	ylim=c(-100, 100))
plot_s(perc$s1, 1)
plot_s(perc$s2, 2)
plot_s(perc$s3, 3)
plot_s(perc$s4, 4)
plot_s(perc$s5, 5)
plot_s(perc$s6, 6)
plot_s(perc$s7, 7)

