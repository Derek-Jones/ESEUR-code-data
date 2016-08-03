#
# commit-circle.R, 16 Jul 16
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


plot_layout(2, 1)
pal_col=rainbow(3)

# id repository_id raw_author_id sha1 merge utc_time local_time
commits=read.csv(paste0(ESEUR_dir, "time-series/commits/scc_commit.tsv.xz"), sep="\t", as.is=TRUE)

commits$sha1=NULL

# 2011-09-09 11:30:27
commits$local_time=as.POSIXct(commits$local_time, format="%Y-%m-%d %H:%M:%S")

hrs_per_day=24
hrs_per_week=hrs_per_day*7
day_angle=seq(0, 359, 360/7)

# 1-Jan-1970 is a Thursday
shift_weekend=3*hrs_per_day

plot_commits=function(df, repo_str, col_str)
{
hrs=as.numeric(round(df$local_time, units="hours")) / (60*60)
week_hr=(shift_weekend+hrs) %% hrs_per_week

# Map to a 360 degree circle
HoW=circular((360/hrs_per_week)*week_hr, units="degrees", rotation="clock")
#plot(HoW, stack=TRUE, shrink=3, axes=FALSE, cex=0.01, col=col_str)
rose.diag(HoW, bins=7*8, shrink=1.2, prop=5, axes=FALSE, col=col_str)
axis.circular(at=circular(day_angle, units="degrees", rotation="clock"),
	labels=c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"))

text(0.8, 1, repo_str, cex=1.4)

arrows.circular(mean(HoW), y=rho.circular(HoW), col=pal_col[2], lwd=3)
# print(c(mean(HoW)[[1]], rho.circular(HoW)))

# lines(density(HoW, bw=30))

return(HoW)
}


# Linux
linux_circ=plot_commits(subset(commits, repository_id == 1), "Linux", pal_col[1])
# FreeBSD
BSD_circ=plot_commits(subset(commits, repository_id == 5), "OpenBSD", pal_col[3])


