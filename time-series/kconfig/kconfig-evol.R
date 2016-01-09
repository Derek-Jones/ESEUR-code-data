#
# kconfig.evol.R, 22 Dec 15
#
# Data from:
# Evolution of the Linux kernel variability model
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


# changes=read.csv(paste0(ESEUR_dir, "time-series/kconfig/kconfig.csv.xz"), as.is=TRUE)
changes=read.csv(paste0(ESEUR_dir, "time-series/kconfig/splc-2010-fm-evol-files-commit-date.gz"), as.is=TRUE)

# changes$date=as.POSIXct(changes$date, format="%a %b %d %X %Y %z")
changes$date=as.Date(changes$date, format="%a %b %d %X %Y %z")
changes=subset(changes, !is.na(changes$date))

# Round date to help smooth things
changes$rnd_date=as.numeric(changes$date) %/% 7

kconfig=subset(changes, kconfig == "Kconfig")
linux=subset(changes, kconfig == "Not Kconfig")

kconfig_hours=table(kconfig$rnd_date)
linux_hours=table(linux$rnd_date)

acf(linux_hours, lag.max=50)

ccf(linux_hours, kconfig_hours, lag.max=50)

xbounds=range(changes$rnd_date)

plot(linux_hours, log="y",
	xlim=xbounds, ylim=c(1, 2600))
points(kconfig_hours, col="red")


