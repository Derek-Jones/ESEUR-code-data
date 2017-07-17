#
# pinchfp.R, 27 Apr 17
# Data from:
# 'AppStore Secrets' ({What} We've Learned from 30,000,0000 Downloads)
# Azeem Ansar
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)


app=read.csv(paste0(ESEUR_dir, "economics/pinchfp.csv.xz"), as.is=TRUE)

free=subset(app, engagement=="free")
paid=subset(app, engagement=="paid")

plot(paid$days, paid$time_spent, col=pal_col[1],
	ylim=c(3.5, 9),
	xlab="Days since first usage", ylab="Time spent (minutes)")
points(free$days, free$time_spent, col=pal_col[2])

lines(loess.smooth(paid$days, paid$time_spent, span=0.5), col=pal_col[1])
lines(loess.smooth(free$days, free$time_spent, span=0.5), col=pal_col[2])

legend(x="topright", legend=c("Paid", "Free"), bty="n", fill=pal_col, cex=1.2)

