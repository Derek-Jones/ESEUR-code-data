#
# agile-day-starts.R, 22 Mar 20
#
# Data from:
# http://www.7digital.com
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG agile_feature feature_duration

source("ESEUR_config.r")


plot_layout(2, 1, max_height=12)

par(mar=MAR_default-c(0.5, 0, 0.8, 0))


pal_col=rainbow(2)


source(paste0(ESEUR_dir, "projects/agile-work/feat-common-7dig.R"))


day_starts=rep(0, end_day)
t=count(as.integer(p$Dev.Started)-base_day)
day_starts[t$x]=t$freq

weekdays=day_starts[-weekends]

plot(weekdays, col=pal_col[2],
	xlab="Days", ylab="Features started\n")

ds_mod=glm(weekdays ~ time(weekdays), family=poisson(link="identity"))

lines(fitted(ds_mod), col=pal_col[1])

# summary(ds_mod)

plot(weekdays-fitted(ds_mod), col=pal_col[2],
	xaxs="i",
	xlab="Days", ylab="Features started\n")


# lwd=log(weekdays+1e-1) # handle days with zero values
# # lwd[is.infinite(lwd)]=0 # handle days with zero values
# 
# ls_mod=glm(lwd ~ time(lwd))
# summary(ls_mod) # a very gentle slope
# 

# library("tseries")
# 
# # Is the time series stationary?
# adf.test(weekdays)
# 
# # We know that this series is stationary
# adf.test(rnorm(length(weekdays)))
# 

