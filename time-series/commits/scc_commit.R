#
# scc_commit.R, 23 Jan 14
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



plot_commits=function(repo_id, c_start, c_end, period)
{
l_commits=subset(commits, repository_id == repo_id)
l_commits=subset(l_commits, (local_time >= c_start) & (local_time < c_end))

l_commits$hours=(as.numeric(l_commits$local_time)-as.numeric(c_start)) %/% period

return(table(l_commits$hours))
}


# Start date picked by looking at data
l_start=as.POSIXct("2005-04-16 00:00:01", format="%Y-%m-%d %H:%M:%S")
l_end=as.POSIXct("2012-01-01 00:00:01", format="%Y-%m-%d %H:%M:%S")

t_l=plot_commits(1, l_start, l_end, 60*60)

l_start=as.POSIXct("1994-01-01 00:00:01", format="%Y-%m-%d %H:%M:%S")
l_end=as.POSIXct("2012-01-01 00:00:01", format="%Y-%m-%d %H:%M:%S")

t_f=plot_commits(5, l_start, l_end, 60*60*12)

