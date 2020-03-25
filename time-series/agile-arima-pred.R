#
# agile-arima-pred.R, 21 Mar 20
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


pal_col=rainbow(3)

source(paste0(ESEUR_dir, "projects/agile-work/feat-common-7dig.R"))


day_starts=rep(0, end_day)
t=count(as.integer(p$Dev.Started)-base_day)
day_starts[t$x]=t$freq

weekdays=day_starts[-weekends]
lwd=log(weekdays+1e-1) # handle days with zero values
# lwd[is.infinite(lwd)]=0 # handle days with zero values

# arima(lwd, order=c(1, 0, 1))


# library("forecast")
#
# plot(forecast(arima(lwd, order=c(5, 0, 1)), h=7), xlim=c(850, 865))

t=predict(arima(lwd, order=c(5, 0, 1)), n.ahead=7)

last_week=tail(lwd, 7)
end_day=857

plot((end_day-6):end_day, last_week, type="l", col=pal_col[2],
	xaxs="i",
	xlim=c(end_day-6, end_day+6), ylim=c(-2.2, 2.3),
	xlab="Days", ylab="Features started per day\n")

lines(t$pred, col=pal_col[1])
lines(t$pred+t$se, col=pal_col[3])
lines(t$pred-t$se, col=pal_col[3])


