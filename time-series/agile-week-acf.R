#
# agile-week-acf.R, 21 Mar 20
#
# Data from:
# http://www.7digital.com
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Agile_feature feature_duration

source("ESEUR_config.r")


plot_layout(2, 1, max_height=12)

par(mar=MAR_default-c(0.5, 0, 0.8, 0))

source(paste0(ESEUR_dir, "projects/agile-work/feat-common-7dig.R"))


day_starts=rep(0, end_day)
t=count(as.integer(p$Dev.Started)-base_day)
day_starts[t$x]=t$freq

# acf(diff(day_starts), xlab="Lag (days)")
# acf(diff(diff(log(day_starts+1e-5)), lag=7))

weekdays=day_starts[-weekends]

lwd=log(weekdays+1e-1) # handle days with zero values
# lwd[is.infinite(lwd)]=0 # handle days with zero values

# pacf(diff(weekdays), xlab="Lag (working days)")
acf(lwd, col=point_col,
	yaxs="i",
	xlab="Lag (working days)", ylab="ACF\n")
pacf(lwd, col=point_col,
	yaxs="i",
	xlab="Lag (working days)", ylab="Partial ACF\n")


# weeks=sapply(seq(0, length(weekdays)-1, by=5), function(X) sum(weekdays[X:(X+4)]))
# weeks=head(weeks, -1) # last entry usually NA
# acf(diff(weeks))
# acf(diff(log(weeks+1e-5)))
# pacf(diff(log(weeks+1e-5)))


