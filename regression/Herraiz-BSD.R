#
# Herraiz-BSD.R, 29 Dec 15
#
# Data from:
#
# A statistical examination of the properties and evolution of libre software
# Israel Herraiz Tabernero
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


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

plot(kind_bsd$Number_days, kind_bsd$sloc, col=point_col,
       xlim=x_lim, ylim=y_lim,
       xlab="Elapsed days", ylab="Lines of code\n")

lin_mod=glm(sloc ~ Number_days, data=kind_bsd)

lin_pred=predict(lin_mod)
lines(lin_pred, col="red")
}



# netbsd=read.csv(paste0(ESEUR_dir, "regression/Herraiz-netbsd.txt.xz"), as.is=TRUE)
# fit_and_plot(netbsd)

freebsd=read.csv(paste0(ESEUR_dir, "regression/Herraiz-freebsd.txt.xz"), as.is=TRUE)
fit_and_plot(freebsd)


