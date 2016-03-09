#
# agile-arima-pred.R,  4 Mar 16
#
# Data from:
# http://www.7digital.com
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)

source(paste0(ESEUR_dir, "projects/agile-work/feat-common-7dig.R"))


day_starts=rep(0, end_day)
t=count(as.integer(p$Dev.Started)-base_day)
day_starts[t$x]=t$freq

weekdays=day_starts[-weekends]

# arima(diff(log(weekdays+1e-8)), order=c(1, 0, 2))


# library("forecast")
#
# plot(forecast(arima(diff(log(weekdays+1e-8)), order=c(5, 0, 1)), h=7), xlim=c(850, 865))

t=predict(arima(diff(log(weekdays+1e-8)), order=c(5, 0, 1)), n.ahead=7)

last_week=tail(weekdays, 7)
end_day=857

plot((end_day-6):end_day, last_week, type="l",
	xlab="Days", ylab="Difference in starting features",
	xlim=c(end_day-6, end_day+6), ylim=c(min(t$pred-t$se), max(t$pred+t$se)))

lines(t$pred, col=pal_col[1])
lines(t$pred+t$se, col=pal_col[2])
lines(t$pred-t$se, col=pal_col[2])


