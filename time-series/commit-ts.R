#
# commit-rs.R, 23 Jan 16
#
# Data from:
# Do time of day and developer experience affect commit bugginess?
# Jon Eyolfson and Lin Tan and Patrick Lam
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



bsd_c=subset(commits, repository_id == 1)
bsd_c=subset(commits, repository_id == 5)

local_time=round(bsd_c$local_time, units="hours")
local_tab=table((as.numeric(local_time)+shift_weekend) %% week_secs)
acf(local_tab)

plot(diff(log(local_tab), lag=24))
acf(diff(log(local_tab), lag=24))
pacf(diff(log(local_tab), lag=24))

