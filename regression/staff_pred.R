#
# staff_pred.R, 17 Mar 20
#
# Data from:
# Designing an Optimal Software Intensive System Acquisition: {A} Game Theoretic Approach
# Douglas John Buettner
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG project_staffing


source("ESEUR_config.r")

pal_col=rainbow(3)


t=read.csv(paste0(ESEUR_dir, "regression/Buettner-A1.csv.xz"), as.is=TRUE)

max_weeks=max(t$Staff.Week.1, na.rm=TRUE)
max_staff=max(t$Staff.Actuals*1.15, na.rm=TRUE)

plot(t$Staff.Week.1, t$Staff.Actuals, col=pal_col[2],
	xaxs="i", yaxs="i",
	xlab="Week", ylab="Estimated people\n",
	xlim=c(0, max_weeks), ylim=c(0, max_staff))

l_mod=loess(Staff.Actuals ~ Staff.Week.1, data=t, span=0.15)

pred_staff=predict(l_mod, se=TRUE,
	newdata=data.frame(Staff.Week.1 = 0:max_weeks))

lines(pred_staff$fit, col=pal_col[1])

lines(pred_staff$fit+1.96*pred_staff$se.fit, col=pal_col[3])
lines(pred_staff$fit-1.96*pred_staff$se.fit, col=pal_col[3])

