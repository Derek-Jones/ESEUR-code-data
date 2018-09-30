#
# agile-duration-ar.R, 18 Feb 16
#
# Data from:
# http://www.7digital.com
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG agile feature duration

source("ESEUR_config.r")

library("ascii")

source(paste0(ESEUR_dir, "projects/agile-work/feat-common-7dig.R"))


day_starts=rep(0, end_day)
t=count(as.integer(p$Dev.Started)-base_day)
day_starts[t$x]=t$freq

weekdays=day_starts[-weekends]

dur_ar=data.frame(
	AR=head(coef(arima(diff(log(weekdays+1e-5)), order=c(5, 0, 1))), n=5),
	Duration=head(count(p$Cycle.Time)$freq/sum(count(p$Cycle.Time)$freq), n=5))

print(ascii(signif(dur_ar, digits=2)))

