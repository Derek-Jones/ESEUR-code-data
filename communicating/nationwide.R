#
# nationwide.R, 5 Mar 19
# Data from:
# IEEE Computer Society/Software Engineering Institute Watts S. Humphrey Software Process Achievment (SPA) Award 2016: Nationwide
# Will J. M. Pohlman
# Figure 6
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG awards

source("ESEUR_config.r")


plot_wide()


nw=read.csv(paste0(ESEUR_dir, "communicating/nationwide.csv.xz"), as.is=TRUE)

nw_mod=glm(productivity ~ date, data=nw)

pred=predict(nw_mod, se.fit=TRUE)

plot(nw$date, nw$productivity, type="b", col="blue",
	xaxt="n",
	xlab="Date", ylab="Delivered productivity")
# There are 28 points in the original plot,
# but 29 months between Sep 13 and Jan 16!
axis(1, at=c(1, 10, 20, 28), labels=c("Sep-13", "Jun-14", "Apr-15", "Jan-16"))
 
lines(nw$date, pred$fit, col="pink", lwd=2)

plot(nw$date, nw$productivity, type="b", col="blue",
	xaxt="n",
	xlab="Date", ylab="Delivered productivity")
# There are 28 points in the original plot,
# but 29 months between Sep 13 and Jan 16!
axis(1, at=c(1, 10, 20, 28), labels=c("Sep-13", "Jun-14", "Apr-15", "Jan-16"))
 
lines(nw$date, pred$fit, col="pink", lwd=2)
lines(nw$date, pred$fit+1.96*pred$se.fit, col="red", lwd=2)
lines(nw$date, pred$fit-1.96*pred$se.fit, col="red", lwd=2)

