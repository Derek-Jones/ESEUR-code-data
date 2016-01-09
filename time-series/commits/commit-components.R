#
# commit-components.R,  1 Aug 15
#
# Data from:
# Do time of day and developer experience affect commit bugginess?
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


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


# BSD_commits=subset(commits, repository_id == 5)
linux_commits=subset(commits, repository_id == 1)
local_time=round(linux_commits$local_time, units="hours")
linux_hr=table((as.numeric(local_time)+shift_weekend) %% week_secs)

# stl does not figure out the recurrence interval, we have to specify it.
hr_ts=ts(linux_hr, start=c(0, 0), frequency=24)
plot(stl(hr_ts, s.window="periodic"))
#	xlab="Days of week")


