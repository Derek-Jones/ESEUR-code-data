#
# commit-components.R, 12 Feb 16
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


# BSD_commits=subset(commits, repository_id == 5)
linux_commits=subset(commits, repository_id == 1)
local_time=round(linux_commits$local_time, units="hours")
linux_hr=table((as.numeric(local_time)+shift_weekend) %% week_secs)
# linux_hr=table((as.numeric(local_time)+shift_weekend) %/% (60*60))

# stl does not figure out the recurrence interval, we have to specify it.
hr_ts=ts(linux_hr, start=c(0, 0), frequency=24)
plot(stl(hr_ts, s.window="periodic"),
	set.pars = list(mar = c(0, 6, 0, 6), oma = c(6, 0, 4, 0),
			las=0, cex.axis=1.1, cex.lab=0.8,
			tck = -0.01, mfrow = c(4, 1)))
#	xlab="Days of week")


# win = window(hr_ts, start=0)
# s_fit = StructTS(win, type = "BSM")
# plot(win)
# lines(fitted(s_fit), col = "green")
# plot(fitted(s_fit))
# 
# plot(cbind(fitted(s_fit), resids=resid(s_fit)))
# 
# tsdiag(s_fit)

