#
# feat-inprog-autocor-7dig.R, 14 Feb 16
#
# Data from:
# http://www.7digital.com feature data
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(2, 2)

source(paste0(ESEUR_dir, "projects/agile-work/feat-common-7dig.R"))


# Autocorrelation of in-progress features
day_totals=sum_day_range(p$Dev.Started, p$Done, 3)
weekday_totals=day_totals[-weekends]

day_totals=rollmean(day_totals, 3) # Just to tidy up the first two plots

hol_days=as.vector(get_ph_days())-base_day
hol_days=hol_days[hol_days > 0 & !is.na(hol_days)]
workday_totals=weekday_totals[-hol_days]

trend=glm(day_totals ~ time(day_totals))
plot(day_totals, xlab="Days since Apr 2009", ylab="Features in-progress")
abline(trend, col="pink")
most_day_totals=day_totals[250:length(day_totals)]
trend=glm(most_day_totals ~ time(most_day_totals))
# Adjust intercept because we fitted values offset by 250
abline(a=trend$coef[1]-trend$coef[2]*250, b=trend$coef[2], col="red")
day_detrend=most_day_totals-predict(trend)
as.Date(base_day)+250
plot(day_detrend, xlab="Days since Jan 2010", ylab="In-progress about mean")
w180_totals=workday_totals[-(1:180)] # remove first 180 days
trend=glm(w180_totals ~ time(w180_totals))
workday_detrend=w180_totals-predict(trend)
acf(day_detrend, lag.max=365, xlab="Lag in Days", main="")
acf(workday_detrend, lag.max=250, xlab="Lag in workdays", main="")

