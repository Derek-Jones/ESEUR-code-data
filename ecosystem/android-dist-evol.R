#
# android-dist-evol.R, 18 Aug 16
#
# Data from:
# Android version distribution history
# Victorien Villard
# http://www.bidouille.org/misc/androidcharts
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")



avd=read.csv(paste0(ESEUR_dir, "communicating/Android-version-distribution_data.csv.xz"), as.is=TRUE)
avd$Date=as.Date(avd$Date, format="%Y-%m-%d")
num_days=as.numeric(avd$Date)-as.numeric(avd$Date[1])
max_days=max(num_days)

# Only interested in versions where we know the start date
avd=subset(avd, select=(avd[1, ] == 0))
num_col=ncol(avd)

pal_col=rainbow(num_col)
max_perc=max(avd[ , -1])

# Display market share based on days since launch
disp_time=function(ver_num)
{
non_zero=which(avd[ , ver_num] > 0)
lines(num_days[non_zero]-num_days[non_zero[1]], avd[non_zero, ver_num], col=pal_col[ver_num])
}

plot(1, type="n",
	xlim=c(0, 1000), ylim=c(0, max_perc),
	xlab="Days since launch", ylab="Percentage of market")
dummy=sapply(1:num_col, disp_time)


ver_str=colnames(avd)
ver_str=sub("X", "", ver_str[-1])

legend(x="topright", legend=ver_str, bty="n", fill=pal_col, cex=1.2)

