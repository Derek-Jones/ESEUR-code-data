#
# Herraiz-BSD.R, 18 Dec 19
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

pal_col=rainbow(2)


fit_and_plot=function(kind_bsd)
{
kind_bsd$date=as.POSIXct(kind_bsd$date, format="%Y-%m-%d")
start_date=kind_bsd$date[1]
kind_bsd$Number_days=as.integer(difftime(kind_bsd$date,
                                         start_date,
                                         units="days"))
# Order by days since first release

plot(kind_bsd$Number_days, kind_bsd$ksloc, col=pal_col[2],
	xaxs="i", yaxs="i",
	xlab="Elapsed days", ylab="Lines of code (thousands)\n")

lin_mod=glm(ksloc ~ Number_days, data=kind_bsd)

lin_pred=predict(lin_mod)
lines(lin_pred, col=pal_col[1])
}



# netbsd=read.csv(paste0(ESEUR_dir, "regression/Herraiz-netbsd.txt.xz"), as.is=TRUE)
# fit_and_plot(netbsd)

freebsd=read.csv(paste0(ESEUR_dir, "regression/Herraiz-freebsd.txt.xz"), as.is=TRUE)

freebsd$ksloc=freebsd$sloc/1e3

fit_and_plot(freebsd)


