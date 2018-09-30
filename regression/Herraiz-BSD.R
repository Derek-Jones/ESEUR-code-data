#
# Herraiz-BSD.R, 23 Sep 18
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

x_lim=c(1, max(kind_bsd$Number_days))
y_lim=c(1, max(kind_bsd$sloc))

plot(kind_bsd$Number_days, kind_bsd$sloc, col=pal_col[2],
       xlim=x_lim, ylim=y_lim,
       xlab="Elapsed days", ylab="Lines of code\n")

lin_mod=glm(sloc ~ Number_days, data=kind_bsd)

lin_pred=predict(lin_mod)
lines(lin_pred, col=pal_col[1])
}



# netbsd=read.csv(paste0(ESEUR_dir, "regression/Herraiz-netbsd.txt.xz"), as.is=TRUE)
# fit_and_plot(netbsd)

freebsd=read.csv(paste0(ESEUR_dir, "regression/Herraiz-freebsd.txt.xz"), as.is=TRUE)
fit_and_plot(freebsd)


