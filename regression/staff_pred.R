#
# staff_pred.R, 14 Feb 16
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


t=read.csv(paste0(ESEUR_dir, "regression/Buettner-A1.csv.xz"), as.is=TRUE)

max_weeks=max(t$Staff.Week.1, na.rm=TRUE)
max_staff=max(t$Staff.Actuals*1.1, na.rm=TRUE)

plot(t$Staff.Week.1, t$Staff.Actuals,
	xlab="Week", ylab="Estimated people\n",
	xlim=c(0, max_weeks), ylim=c(0, max_staff))

l_mod=loess(Staff.Actuals ~ Staff.Week.1, data=t, span=0.15)

pred_staff=predict(l_mod, se=TRUE,
	newdata=data.frame(Staff.Week.1 = 0:max_weeks))

lines(pred_staff$fit, col=brew_col[2])

lines(pred_staff$fit+1.96*pred_staff$se.fit, col=brew_col[1])
lines(pred_staff$fit-1.96*pred_staff$se.fit, col=brew_col[1])

