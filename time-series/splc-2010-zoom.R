#
# splc-2010-zoom.R, 21 Mar 20
#
# Data from:
# Evolution of the Linux kernel variability model
# Lotufo, She, Berger, Czarnecki and Wasowski
# Figure 3
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Linux_variability Linux_kconfig Evolution_Linux

source("ESEUR_config.r")


library("lubridate")
library("plyr")


pal_col=rainbow(2)


# Some day dates are missing from the data.  Add them in as zeroes.
day_count=function(df)
{
t=count(df$date)

d_cnt=data.frame(date=seq(min(t$x), max(t$x), "days"), freq=0)
d_cnt$freq[d_cnt$date %in% t$x]=t$freq

return(d_cnt)
}



# changes=read.csv(paste0(ESEUR_dir, "time-series/kconfig.csv.xz"), as.is=TRUE)
changes=read.csv(paste0(ESEUR_dir, "time-series/splc-2010-fm-evol-files-commit-date.xz"), as.is=TRUE)

# changes$date=as.POSIXct(changes$date, format="%a %B %d %H:%M:%S %Y %z")
changes$date=as.Date(changes$date, format="%a %B %d %H:%M:%S %Y %z")
changes=subset(changes, !is.na(changes$date))

# Round date to help smooth things
changes$rnd_date=round_date(changes$date, unit="week")

kconfig=subset(changes, kconfig == "Kconfig")
linux=subset(changes, kconfig == "Not Kconfig")

kconfig_day=day_count(kconfig)
linux_day=day_count(linux)

kconfig_week=count(kconfig$rnd_date)
linux_week=count(linux$rnd_date)

# acf(linux_day$freq, lag.max=50)
# 
# ccf(linux_day$freq, kconfig_day$freq, lag.max=50)
# 
# plot(linux_day$x, linux_day$freq, type="l", log="y", col=pal_col[2],
# 	xaxs="i",
# 	ylim=c(1, 2600),
# 	xlab="Date", ylab="Commits\n")
# lines(kconfig_day, col=pal_col[1])
# 
# legend(x="bottomright", legend=c("Kconfig", "Linux"), bty="n", fill=pal_col, cex=1.2)

start_day=linux_week$x[1]+60
end_day=start_day+144

# Overlay plots, so we can see which series is the 'oldest',
# i.e., which peak starts first
plot(linux_week$x, linux_week$freq, type="l", log="y", col=pal_col[2],
	xlim=c(start_day, end_day), ylim=c(50, 1200),
	xlab="Date", ylab="Commits\n")

lines(kconfig_week$x, kconfig_week$freq*10, col=pal_col[1])

legend(x="bottomright", legend=c("Kconfig", "Linux kernel"), bty="n", fill=pal_col, cex=1.2)

