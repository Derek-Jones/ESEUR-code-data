#
# Herraiz-BSD-season.R, 23 Sep 18
#
# Data from:
#
# A statistical examination of the properties and evolution of libre software
# Israel Herraiz Tabernero
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG FreeBSD evolution LOC


source("ESEUR_config.r")

pal_col=rainbow(3)


fit_and_summary=function(kind_bsd)
{
kind_bsd$date=as.POSIXct(kind_bsd$date, format="%Y-%m-%d")
start_date=kind_bsd$date[1]
kind_bsd$Number_days=as.integer(difftime(kind_bsd$date,
                                         start_date,
                                         units="days"))
# Order by days since first release

# lin_mod=glm(sloc ~ Number_days, data=kind_bsd)
# print(summary(lin_mod))

rad_per_day=(2*pi)/365
kind_bsd$rad_Number_days=rad_per_day*kind_bsd$Number_days

season_mod=glm(sloc ~ Number_days+
                        sin(rad_Number_days)+cos(rad_Number_days),
                                                     data=kind_bsd)
print(summary(season_mod))
}



# netbsd=read.csv(paste0(ESEUR_dir, "regression/Herraiz-netbsd.txt.xz"), as.is=TRUE)
# fit_and_summary(netbsd)

freebsd=read.csv(paste0(ESEUR_dir, "regression/Herraiz-freebsd.txt.xz"), as.is=TRUE)
fit_and_summary(freebsd)

# plot(stl(ts(freebsd$sloc, frequency=265), s.window="period"))

