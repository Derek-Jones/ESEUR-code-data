#
# Android-distribution.R,  4 Mar 20
#
# Data from:
#
# http://www.bidouille.org/misc/androidcharts
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Android_ecosystem Android_market-share


source("ESEUR_config.r")


plot_layout(2, 2)
par(mar=MAR_default-c(0.0, 0.0, 0.7, 0.0))


avd=read.csv(paste0(ESEUR_dir, "communicating/Android-version-distribution_data.csv.xz"), as.is=TRUE)
avd$Date=as.Date(avd$Date, format="%Y-%m-%d")

num_col=ncol(avd)-1
max_perc=max(avd[ , -1])

# Display individual market share over time
disp_time=function(ver_num)
{
lines(avd$Date, avd[ , ver_num+1], col=pal_col[ver_num])
}


# Display cumulative markey share over time
market_poly=function(ver_num)
{
polygon(c(avd$Date, rev(avd$Date)), c(cum_avd[ , ver_num], rev(cum_avd[ , ver_num+1])), col=pal_col[ver_num])
}


plot_time_poly=function()
{
# A plot frame is needed
plot(avd$Date, avd[ , 1+1], type="n",
	xaxs="i", yaxs="i",
	ylim=c(0, max_perc),
	xlab="", ylab="Percentage of market\n")
dummy=sapply(1:num_col, disp_time)

plot(avd$Date, rep(0, length(avd$Date)), type="n",
	xaxs="i", yaxs="i",
	ylim=c(0, 100),
	xlab="Date", ylab="Percentage of market\n")

dummy=sapply(1:num_col, market_poly)
}


# Add in lower and upper bounds of cumulative totals
cum_avd=t(apply(cbind(rep(0, nrow(avd)), avd[ , 2:num_col]), 1, cumsum))
cum_avd=cbind(cum_avd, rep(100, nrow(avd)))

pal_col=rainbow_hcl(num_col)
plot_time_poly()

pal_col=rainbow(num_col)
plot_time_poly()

