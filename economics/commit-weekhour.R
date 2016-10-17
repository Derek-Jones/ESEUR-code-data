#
# commit-weekhour.R, 22 Feb 16
#
# Data from:
# Do time of day and developer experience affect commit bugginess?
# Jon Eyolfson and Lin Tan and Patrick Lam
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

pal_col=rainbow(2)

# id repository_id raw_author_id sha1 merge utc_time local_time
commits=read.csv(paste0(ESEUR_dir, "time-series/commits/scc_commit.tsv.xz"), sep="\t", as.is=TRUE)

commits$sha1=NULL

# 2011-09-09 11:30:27
commits$utc_time=as.POSIXct(commits$utc_time, format="%Y-%m-%d %H:%M:%S")
commits$local_time=as.POSIXct(commits$local_time, format="%Y-%m-%d %H:%M:%S")

day_secs=60*60*24
week_secs=day_secs*7
week_hr_secs=0:(24*7-1)

# 1-Jan-1970 is a Thursday
shift_weekend=3*day_secs

plot_commits=function(df, col_str)
{
local_time=round(df$local_time, units="hours")

lines(week_hr_secs, table((as.numeric(local_time)+shift_weekend) %% week_secs), col=col_str)

}


plot(week_hr_secs, type="n",
	xaxt="n",
	ylim=c(0, 4500),
	xlab="", ylab="Commits within hour\n")
# Linux
plot_commits(subset(commits, repository_id == 1), pal_col[1])
# FreeBSD
plot_commits(subset(commits, repository_id == 5), pal_col[2])

axis(1, at=seq(0, 24*7, by=24), hadj=0,
	labels=c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun", "Mon"))
legend(x="topright", legend=c("Linux", "FreeBSD"),
			bty="n", fill=pal_col, cex=1.2)

