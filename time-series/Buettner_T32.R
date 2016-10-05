#
# Buettner_T32.R,  1 Oct 16
#
# Data from:
# Designing an Optimal Software Intensive System Acquisition: {A} Game Theoretic Approach
# Douglas John Buettner
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


library("plyr")


brew_col=rainbow(2)

# Project C
bt_c=read.csv(paste0(ESEUR_dir, "time-series/Buettner_T32.csv.xz"), as.is=TRUE)
bt_c=subset(bt_c, !is.na(bt_c$Day))

dt_c=ddply(bt_c, .(Day), function(df) return(nrow(df)))

bc_ts=rep(0, max(bt_c$Day))
bc_ts[dt_c$Day]=dt_c$V1
# Remove the startup days when no faults were reported
bc_ts=bc_ts[min(bt_c$Day):max(bt_c$Day)]

acf(bc_ts, lag.max=100, col=point_col)


# plot(bc_ts)
# lines(loess.smooth(1:length(bc_ts), bc_ts, span=0.3), col=loess_col)


# What is the offset for Sunday?
# This should be where all the days have zero faults reported
# day=seq(1, length(bc_ts), by=7)
# sapply(0:6, function(X) table(bc_ts[day+X]))

# Saturday is offset 1, so add these counts to Friday
# bc_ts[day+6]=bc_ts[day+6]+bc_ts[day]

# Remove Saturday+Sunday
# work_ts=bc_ts[-c(day, day+1)]

# acf(work_ts[-c(1019, 1020)])

# fw=sapply(seq(1, length(bc_ts), by=7), function(X) sum(bc_ts[X+0:6]))
# fault_week=data.frame(faults=fw, day=1:length(fw))

# plot(work_ts, col=point_col,
# 	xlab="Date", ylab="Faults reported")
# lines(loess.smooth(1:length(work_ts), work_ts, span=0.3), col=loess_col)

# fault_day=data.frame(faults=work_ts, day=1:length(work_ts))

# library("gnm")

# fail_mod=gnm(faults ~ Mult(I(day^2), Exp(day))-1,
# 		data=fault_day,
# 		trace=FALSE, verbose=TRUE,
# 		start=c(0.2, -0.001),
# 		family=poisson(link="identity"))

# pred=predict(fail_mod, type="response")
# lines(pred, col="red")


