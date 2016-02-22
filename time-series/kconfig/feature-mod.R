#
# feature-mod.R, 15 Feb 16
#
# Data from:
# Evolution of the Linux kernel variability model
# Lutufo, She, Berger, Czarnecki and Wasowski
# Figure 3
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("dtw")
library("lubridate")
library("plyr")


str_to_hours=function(date_str)
{
return(as.integer(round(as.numeric(strptime(date_str,
		             format="%a %B %d %H:%M:%S %Y %z"))/3600)))
}

time_to_vect=function(day_changes, start_time)
{
dc_count=count(day_changes)
time_vec=dc_count$x
tk=rep(0, max(time_vec))
tk[time_vec]=dc_count$freq

return(tk)
}

# changes=read.csv(paste0(ESEUR_dir, "evolution/linux-kconfig/splc-2010-fm-evol-files-commit-date.gz"), as.is=TRUE)
# The row format is: Sat Apr 16 15:23:53 2005 -0700
changes=read.csv(paste0(ESEUR_dir, "time-series/kconfig/kconfig.csv.xz"), as.is=TRUE)
changes$date=as.Date(changes$date, format="%a %B %d %H:%M:%S %Y %z")
changes$days=as.integer(changes$date)
changes$days=changes$days-changes$days[1]+1
changes$weeks=as.integer(floor_date(changes$date, "week"))
changes$weeks=(changes$weeks-changes$weeks[1])/7+1


kconfig_days=time_to_vect(subset(changes, kconfig == "Kconfig")$days)
linux_days=time_to_vect(subset(changes, kconfig == "Not Kconfig")$days)


# plot(3*sqrt(linux_days), type="h")
plot(linux_days, type="h")
points(kconfig_days, type="h", col="red")

acf(linux_days, lag=100)
pacf(linux_days, lag=100)
acf(kconfig_days, lag=100)
pacf(kconfig_days, lag=100)

ccf(linux_days, kconfig_days, lag=100)

kconfig_weeks=time_to_vect(subset(changes, kconfig == "Kconfig")$weeks)
linux_weeks=time_to_vect(subset(changes, kconfig == "Not Kconfig")$weeks)
plot(linux_weeks, type="h")
points(kconfig_weeks, type="h", col="red")



alignment = dtw(linux_weeks, kconfig_weeks, keep=TRUE)
alignment = dtw(3*sqrt(linux_weeks), kconfig_weeks, keep=TRUE, step.pattern=asymmetric)
# alignment$distance
plot(alignment)

contour(alignment$costMatrix,col=terrain.colors(100), x=1:252, y=1:252)
lines(alignment$index1,alignment$index2,col="red",lwd=2)

# library("TSclust")
#
# two_series=data.frame(src=linux_vect, kconfig=c(kconfig_vect, 0, 0))
# 
# t=diss(two_series, "ACF")

# How to analyse spikes in data???

# Compare correlation tests when value vectors are off by 1
cor.test(linux_vect, c(kconfig_vect, 0))
cor.test(linux_vect, c(0,kconfig_vect))

kconfig_change=count(str_to_hours(subset(changes, kconfig == "Kconfig")$date))
linux_change=count(str_to_hours(subset(changes, kconfig == "Not Kconfig")$date))

kconfig_vect=time_to_vect(kconfig_change, start_hour)
linux_vect=time_to_vect(linux_change, start_hour)

ccf(linux_vect, kconfig_vect, lag=48)

