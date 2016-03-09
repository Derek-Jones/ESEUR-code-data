#
# agile-arima.R, 19 Feb 16
#
# Data from:
# http://www.7digital.com
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


source(paste0(ESEUR_dir, "projects/agile-work/feat-common-7dig.R"))


day_starts=rep(0, end_day)
t=count(as.integer(p$Dev.Started)-base_day)
day_starts[t$x]=t$freq

weekdays=day_starts[-weekends]

print(arima(diff(log(weekdays+1e-8)), order=c(1, 0, 2)))


