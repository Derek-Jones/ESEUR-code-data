#
# Buettner.R, 14 Feb 16
#
# Data from:
# Designing an Optimal Software Intensive System Acquisition: {A} Game Theoretic Approach
# Douglas John Buettner
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


brew_col=rainbow(2)

t=read.csv(paste0(ESEUR_dir, "time-series/Buettner-Data_C1_request.csv.xz"), as.is=TRUE)


# Plot points, fit a loess curve and plot with standard error
max_weeks=max(t$Week, na.rm=TRUE)
max_staff=max(t$Effort.Hours.Actual, na.rm=TRUE)

plot(t$Week, t$Effort.Hours.Actual,
	xlab="Week", ylab="Estimated people",
	xlim=c(0, max_weeks), ylim=c(0, max_staff))

l_mod=loess(Effort.Hours.Actual ~ Week, data=t, span=0.15)

pred_staff=predict(l_mod, se=TRUE,
	newdata=data.frame(Week = 0:max_weeks))

lines(pred_staff$fit, type="l", col=brew_col[2])
lines(pred_staff$fit+1.96*pred_staff$se.fit, type="l", col=brew_col[1])
lines(pred_staff$fit-1.96*pred_staff$se.fit, type="l", col=brew_col[1])

points(t$Week.2, t$All.Staff.1*130, col="red")


cor.test(t$Effort.Hours.Actual, as.numeric(t$Effort.Hours.Planned))


library(plyr)

# Autocorrelation of faults reported per day

mk_acf=function(bugs, ignore=0, lag=100)
{
dt=ddply(bugs, .(Day), function(df) return(length(which(!(df$Sev %in% ignore)))))

b_ts=rep(0, max(dt$Day))
b_ts[dt$Day]=dt$V1
b_ts=b_ts[min(bugs$Day):max(bugs$Day)]

acf(b_ts, lag.max=lag, xlab=paste("Ignore =", ignore, collapse=","))
}


# Project A
bt_a=read.csv("/usr1/data-rbook/Buettner/Buettner_T31.csv.xz", as.is=TRUE)
bt_a=subset(bt_a, !is.na(bt_a$Day))

# Sum faults reported in each day
dt_a=ddply(bt_a, .(Day), function(df) return(nrow(df)))

# Fill in the zeroes
ba_ts=rep(0, max(bt_a$Day))
ba_ts[dt_a$Day]=dt_a$V1

spectrum(ba_ts, method="ar")

acf(ba_ts, lag.max=100)


# Project C
bt_c=read.csv(paste0(ESEUR_dir, "time-series/Buettner/Buettner_T32.csv.xz"), as.is=TRUE)
bt_c=subset(bt_c, !is.na(bt_c$Day))

dt_c=ddply(bt_c, .(Day), function(df) return(nrow(df)))

bc_ts=rep(0, max(bt_c$Day))
bc_ts[dt_c$Day]=dt_c$V1
# Remove the styartup days where no faults reported
bc_ts=bc_ts[min(bt_c$Day):max(bt_c$Day)]

acf(bc_ts, lag.max=100)


spectrum(bc_ts, method="ar")

mk_acf(bt_c, ignore=c(3), lag=400)
mk_acf(bt_c, ignore=c(1, 2, 4, 5), lag=400)

mk_acf(bt_c, ignore=c(5), lag=500)
mk_acf(bt_c, ignore=c(4, 5), lag=500)
mk_acf(bt_c, ignore=c(1, 2, 3, 5), lag=500)

max_row=max(bc_ts)+1
bc_bounds=1:(length(bc_ts)-1)

heat_map=matrix(data=0, nrow=max_row, ncol=max_row)
t=aaply(cbind(bc_ts[bc_bounds], bc_ts[bc_bounds+1]), 1,
	function(df) {
		heat_map[df[1], df[2]] <<- heat_map[df[1], df[2]]+1
		return(0)
		})

heatmap(heat_map[1:10, 1:10], Rowv=NA, Colv=NA)


library("zoo")

plot(bc_ts)
plot(rollmean(bc_ts, 7))
plot(rollmean(bc_ts, 14))
plot(rollmean(bc_ts, 21))
plot(rollmean(bc_ts, 28))


hist(ba_ts[ba_ts !=0], freq=FALSE, breaks=1:50, col="red",
	main="project A is red", xlab="Faults per day",
	xlim=c(1, 15), ylim=c(0, 0.8))
par(new=TRUE)
hist(bc_ts[bc_ts !=0], freq=FALSE, breaks=1:50,
	main="", xlab="",
	xlim=c(1, 15), ylim=c(0, 0.8))

plot(log(table(ba_ts)), type="b", col="red",
	    xlim=c(0, 25), ylim=c(0, 7.5))
par(new=TRUE)
plot(log(table(bc_ts)), type="b", col="green",
	    xlim=c(0, 25), ylim=c(0, 7.5))


