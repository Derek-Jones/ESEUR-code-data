#
# agile-week-acf.R, 14 Oct 16
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

# acf(diff(day_starts), xlab="Lag (days)")
# acf(diff(diff(log(day_starts+1e-5)), lag=7))

weekdays=day_starts[-weekends]
# pacf(diff(weekdays), xlab="Lag (working days)")
acf(diff(log(weekdays+1e-5)), xlab="Lag (working days)", col=point_col)
pacf(diff(log(weekdays+1e-5)), xlab="Lag (working days)", col=point_col)


# weeks=sapply(seq(0, length(weekdays)-1, by=5), function(X) sum(weekdays[X:(X+4)]))
# weeks=head(weeks, -1) # last entry usually NA
# acf(diff(weeks))
# acf(diff(log(weeks+1e-5)))
# pacf(diff(log(weeks+1e-5)))


