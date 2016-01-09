#
# linux-bsd-commits.R,  1 Jul 14
#
# Data from:
# Do time of day and developer experience affect commit bugginess?
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

plot_layout(1, 2)

# id repository_id raw_author_id sha1 merge utc_time local_time
commits=read.csv(paste0(ESEUR_dir, "time-series/commits/scc_commit.tsv.xz"), sep="\t", as.is=TRUE)

commits$sha1=NULL

# 2011-09-09 11:30:27
commits$utc_time=as.POSIXct(commits$utc_time, format="%Y-%m-%d %H:%M:%S")
commits$local_time=as.POSIXct(commits$local_time, format="%Y-%m-%d %H:%M:%S")

day_secs=60*60*24
week_secs=day_secs*7

# 1-Jan-1970 is a Thursday
shift_weekend=3*day_secs

plot_commits=function(df, code_base)
{
local_time=round(df$local_time, units="hours")

plot(table((as.numeric(local_time)+shift_weekend) %% week_secs),
	type="l", xaxt="n",
	xlab=code_base, ylab="Commits per hour")

axis(1, at=seq(0, week_secs, by=day_secs), hadj=0,
	labels=c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun", "Mon"))
}


# Linux
plot_commits(subset(commits, repository_id == 1), "Linux")

# FreeBSD
plot_commits(subset(commits, repository_id == 5), "FreeBSD")


