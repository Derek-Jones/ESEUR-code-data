#
# splc-2010-fm.R, 23 Mar 20
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
# TAG Linux_variability Linux_kconfig evolution_Linux Linux_variability

source("ESEUR_config.r")


library("lubridate")
library("plyr")


pal_col=rainbow(2)


# changes=read.csv(paste0(ESEUR_dir, "time-series/kconfig.csv.xz"), as.is=TRUE)
changes=read.csv(paste0(ESEUR_dir, "time-series/splc-2010-fm-evol-files-commit-date.xz"), as.is=TRUE)

# changes$date=as.POSIXct(changes$date, format="%a %B %d %H:%M:%S %Y %z")
changes$date=as.Date(changes$date, format="%a %B %d %H:%M:%S %Y %z")
changes=subset(changes, !is.na(changes$date))

# Round date to help smooth things
changes$rnd_date=round_date(changes$date, unit="week")

kconfig=subset(changes, kconfig == "Kconfig")
linux=subset(changes, kconfig == "Not Kconfig")

kconfig_week=count(kconfig$rnd_date)
linux_week=count(linux$rnd_date)

# acf(linux_week$freq, lag.max=50)
# 
# ccf(linux_week$freq, kconfig_week$freq, lag.max=50)

plot(linux_week$x, linux_week$freq, type="l", log="y", col=pal_col[2],
	xaxs="i",
	ylim=c(1, 2600),
	xlab="Date", ylab="Commits\n")
lines(kconfig_week, col=pal_col[1])

legend(x="bottomright", legend=c("Kconfig", "Linux"), bty="n", fill=pal_col, cex=1.2)


# library("rugarch")
# 
# 
# # Day granularity produces a better fit
# kconfig_day=count(kconfig$date)
# linux_day=count(linux$date)
# 
# g_spec=ugarchspec() # standard specification (what do I know)
# 
# ug_mod=ugarchfit(spec=g_spec, data=linux_hours$freq)
# ug_mod
# 

