#
# stabl.R, 17 Dec 15
#
# Data from:
# Stabilizer: Statistically sound performance evaluation
# Charlie Curtsinger and Emery D. Berger
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")


bench=read.csv(paste0(ESEUR_dir, "benchmark/misc/qq_data.csv.xz"), as.is=TRUE)

ran=subset(bench, ext == "randomized")


plot_ran_re=function(df)
{
r=sort(subset(df, ext == "randomized")$time)
rr=sort(subset(df, ext != "randomized")$time)

xbounds=c(0, max(length(r), length(rr)))
ybounds=range(c(r, rr))

plot(r, xlim=xbounds, ylim=ybounds,
	ylab="Time")
points(rr, col="red")
}


par(mfcol=c(4,5))
d_ply(bench, .(benchmark), plot_ran_re)

# Don't understand the pattern of behavior...
# Does not look right...

