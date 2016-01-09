#
# agile-arima.R, 29 Jul 15
#
# Data from:
# http://www.7digital.com
#
# R code for book "Empirical Software Engineering using R"
# Derek M. Jones, http://shape-of-code.coding-guidelines.com
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")



p=read.csv(paste0(ESEUR_dir, "projects/agile-work/7digital2012.csv.xz"))

p$Dev.Started=as.Date(p$Dev.Started, "%d/%m/%Y")
p$Done=as.Date(p$Done, "%d/%m/%Y")
# Bracket the data start/end dates
base_date="20/04/2009"  # a Monday
base_day=as.integer(as.Date(base.date, "%d/%m/%Y"))
end_day=as.integer(as.Date("01/08/2012", "%d/%m/%Y"))-base_day

weekends=c(seq(5, end.day ,by=7), # Saturday
           seq(6, end.day, by=7))


day_starts=rep(0, end_day)
t=table(as.integer(p$Dev.Started)-base_day)
day_starts[as.integer(names(t))]=t

weekdays=day_starts[-weekends]
# acf(diff(log(weekdays+0.00001)))

at=arima(log(weekdays+0.00001), c(2, 1, 2))
tsdiag(at)

