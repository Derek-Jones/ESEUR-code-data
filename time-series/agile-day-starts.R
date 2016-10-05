#
# agile-day-starts.R, 30 Sep 16
#
# Data from:
# http://www.7digital.com
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(2, 1)

source(paste0(ESEUR_dir, "projects/agile-work/feat-common-7dig.R"))


day_starts=rep(0, end_day)
t=count(as.integer(p$Dev.Started)-base_day)
day_starts[t$x]=t$freq

weekdays=day_starts[-weekends]

plot(weekdays, col=point_col,
	xlab="Days", ylab="Features started")

ds_mod=glm(weekdays ~ time(weekdays), family=poisson(link="identity"))

lines(fitted(ds_mod), col="blue")

# summary(ds_mod)

plot(weekdays-fitted(ds_mod), col=point_col,
	xlab="Days", ylab="Features started")

