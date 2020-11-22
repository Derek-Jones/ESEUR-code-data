#
# 13-ext-reg.R, 23 Apr 20
#
# Data from:
# Correlations between Bugginess and Time-Based Commit Characteristics
# Jon Eyolfson and Lin Tan and Patrick Lam
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG commit_time-of-day fault_time-of-day


source("ESEUR_config.r")

library("circular")
library("plyr")


pal_col=rainbow(4)


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
	xaxs="i", yaxs="i",
	ylim=c(0, 3500),
	xlab="Hour", ylab="Commits\n")

legend(x="topleft", legend=c("non-fault commits", "fault commits"), bty="n", fill=c(pal_col[2], pal_col[4]), cex=1.2)

basic_mod = nls(freq ~ gam0+gam1*cos(omega*hour-phi+nu*cos(omega*hour-phi)),
                start = list(gam0 = 800, gam1 = 700, omega=0.3, phi = 1, nu = 0),
		data=week_basic)

pred=predict(basic_mod, newdata=data.frame(hour=day))
lines(day, pred, col=pal_col[1])


points(week_fault$hour, week_fault$freq, col=pal_col[4])

fault_mod = nls(freq ~ gam0+gam1*cos(omega*hour-phi+nu*cos(omega*hour-phi)),
                start = list(gam0 = 800, gam1 = 700, omega=0.3, phi = 1, nu = 0),
		data=week_fault)

pred=predict(fault_mod, newdata=data.frame(hour=day))
lines(day, pred, col=pal_col[3])


