#
# 13-ext-reg.R, 16 Jul 16
#
# Data from:
# Do time of day and developer experience affect commit bugginess?
# Jon Eyolfson and Lin Tan and Patrick Lam
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

library("circular")
library("plyr")


plot_layout(2, 1)
pal_col=rainbow(3)


sum_commits=function(df)
{
t=count(df$hour)

return(data.frame(hour=t$x, freq=t$freq))
}


day=0:23

# id repository_id raw_author_id sha1 merge utc_time local_time
commits=read.csv(paste0(ESEUR_dir, "time-series/commits/scc_commitbasicinformation.tsv.xz"), sep="\t", as.is=TRUE)

commits$is_introducing= (commits$is_introducing == "t")
commits$is_fixing= (commits$is_fixing == "t")

fault_commits=subset(commits, is_introducing)
basic_commits=subset(commits, !is_introducing)


fault_total=ddply(fault_commits, .(week_day), sum_commits)
basic_total=ddply(basic_commits, .(week_day), sum_commits)

week_fault=subset(fault_total, week_day < 5)
week_basic=subset(basic_total, week_day < 5)

plot(week_basic$hour, week_basic$freq, col=pal_col[2],
	xlab="Hour", ylab="non-fault commits\n")

basic_mod = nls(freq ~ gam0+gam1*cos(omega*hour-phi+nu*cos(omega*hour-phi)),
                start = list(gam0 = 800, gam1 = 700, omega=0.3, phi = 1, nu = 0),
		data=week_basic)

pred=predict(basic_mod, newdata=data.frame(hour=day))
lines(day, pred, col=pal_col[3])


plot(week_fault$hour, week_fault$freq, col=pal_col[2],
	xlab="Hour", ylab="Fault commits\n")

fault_mod = nls(freq ~ gam0+gam1*cos(omega*hour-phi+nu*cos(omega*hour-phi)),
                start = list(gam0 = 800, gam1 = 700, omega=0.3, phi = 1, nu = 0),
		data=week_fault)

pred=predict(fault_mod, newdata=data.frame(hour=day))
lines(day, pred, col=pal_col[1])


