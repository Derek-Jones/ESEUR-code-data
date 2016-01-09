#
# feature-mod.R, 22 Dec 15
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

str_to_days=function(date.str)
{
return(as.integer(as.Date(date.str,
		          format="%a %B %d %H:%M:%S %Y")))
}

str_to_hours=function(date.str)
{
return(as.integer(round(as.numeric(strptime(date.str,
		             format="%a %B %d %H:%M:%S %Y"))/1800)))
}

time_to_vect=function(day.changes, start.time)
{
time_vec=as.integer(names(day.changes))-start.time
tk=rep(0, max(time_vec))
tk[time_vec]=as.vector(day.changes)

return(tk)
}

# changes=read.csv(paste0(ESEUR_dir, "evolution/linux-kconfig/splc-2010-fm-evol-files-commit-date.gz"), as.is=TRUE)
# The row format is: Sat Apr 16 15:23:53 2005 -0700
changes=read.csv(paste0(ESEUR_dir, "time-series/kconfig/kconfig.csv.xz"), as.is=TRUE)

start.day=str_to_days(changes$date[1])-1
start.hour=str_to_hours(changes$date[1])-1

kconfig.change=table(str_to_days(changes$date[changes$kconfig == "Kconfig"]))
linux.change=table(str_to_days(changes$date[changes$kconfig == "Not Kconfig"]))

kconfig.vect=time_to_vect(kconfig.change, start.day)
linux.vect=time_to_vect(linux.change, start.day)

plot(linux.vect, type="h",
	ylim=c(0, 1600))
points(kconfig.vect, type="h", col="red")

acf(linux.vect, lag=100)
pacf(linux.vect, lag=100)
acf(kconfig.vect, lag=100)
pacf(kconfig.vect, lag=100)

ccf(linux.vect, kconfig.vect, lag=100)

# How to analyse spikes in data???

# Compare correlation tests when value vectors are off by 1
cor.test(linux.vect, c(kconfig.vect, 0))
cor.test(linux.vect, c(0,kconfig.vect))

kconfig.change=table(str_to_hours(changes$date[changes$kconfig == "Kconfig"]))
linux.change=table(str_to_hours(changes$date[changes$kconfig == "Not Kconfig"]))

kconfig.vect=time_to_vect(kconfig.change, start.hour)
linux.vect=time_to_vect(linux.change, start.hour)

ccf(linux.vect, kconfig.vect, lag=48)

