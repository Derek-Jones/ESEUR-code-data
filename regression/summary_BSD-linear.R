#
# summary_BSD-linear.R, 19 Dec 15
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

plot_layout(1, 2)

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

# plot(kind_bsd$Number_days, kind_bsd$sloc,
#        xlim=x_lim, ylim=y_lim,
#        xlab="Days", ylab="Lines of code")

lin_mod=glm(sloc ~ Number_days, data=kind_bsd)

print(summary(lin_mod))

# aov(lin_mod)

# lines(kind_bsd$Number_days, predict(lin_mod),	col="red")
}



netbsd=read.csv(paste0(ESEUR_dir, "regression/Herraiz-netbsd.txt.xz"), as.is=TRUE)
fit_and_plot(netbsd)

# freebsd=read.csv(paste0(ESEUR_dir, "regression/Herraiz-freebsd.txt.xz"), as.is=TRUE)
# fit_and_plot(freebsd)


