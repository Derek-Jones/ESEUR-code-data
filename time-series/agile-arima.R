#
# agile-arima.R, 21 Mar 20
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


source(paste0(ESEUR_dir, "projects/agile-work/feat-common-7dig.R"))


day_starts=rep(0, end_day)
t=count(as.integer(p$Dev.Started)-base_day)
day_starts[t$x]=t$freq

weekdays=day_starts[-weekends]
lwd=log(weekdays+1e-1) # handle days with zero values
# lwd=log(weekdays)
# lwd[is.infinite(lwd)]=0 # handle days with zero values

print(arima(lwd, order=c(1, 0, 1)))


