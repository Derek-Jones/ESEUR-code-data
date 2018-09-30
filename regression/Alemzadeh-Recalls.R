#
# Alemzadeh-Recalls.R, 23 Sep 18
#
# Data from:
# Analysis of safety-critical computer failures in medical devices
# Homa Alemzadeh and Ravishankar K. Iyer and Zbigniew Kalbarczyk and Jai Raman
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG hardware-recall safety-critical medical


source("ESEUR_config.r")

plot_layout(2, 1)
pal_col=rainbow(4)

# Recall_Number,Date,Year,Trade_Name,Recalling_Firm,Recall_Class,Reason_Recall,Action
comp_recalls=read.csv(paste0(ESEUR_dir, "regression/Alemzadeh-Computer_Related_Recalls.csv.xz"), as.is=TRUE)

comp_recalls$Date=as.Date(comp_recalls$Date, format="%b-%d-%Y")

#recall_subset=subset(comp_recalls, Date <= as.Date("2010-12-31"))

t1=cut(comp_recalls$Date, breaks=72)
t2=table(t1)

x_axis=1:length(t2)
y_axis=as.vector(t2)
y_bounds=range(y_axis)

plot(t2, type="p", col=pal_col[3],
	ylim=y_bounds,
	xlab="Fortnights", ylab="Reported product recalls\n")

loess_mod=loess(y_axis ~ x_axis, span=0.3)

fortnight_pred=predict(loess_mod)

lines(x_axis, fortnight_pred, col=loess_col)

# l_mod=glm(y_axis ~ x_axis, family=quasipoisson(link="identity"))
l_mod=glm(y_axis ~ x_axis)

# l_mod=glm(y_axis ~ x_axis, family=quasipoisson(link="identity"))
l_mod=glm(y_axis ~ x_axis)

pred=predict(l_mod, se.fit=TRUE)

lines(x_axis, pred$fit, col=pal_col[1])
lines(x_axis, pred$fit+1.96*pred$se.fit, col=pal_col[2])
lines(x_axis, pred$fit-1.96*pred$se.fit, col=pal_col[2])

#influenceIndexPlot(l_mod, main="")


# l_mod=glm(y_axis ~ x_axis, family=quasipoisson(link="identity"))
l_mod=glm(y_axis ~ x_axis)
orig_pred=predict(l_mod)

t2[33]=round(mean(y_axis))
#t2[34]=round(mean(y_axis))
t2[67]=round(mean(y_axis))
y_axis=as.vector(t2)

plot(t2, type="p", col=pal_col[3],
	ylim=y_bounds,
	xlab="Fortnights", ylab="Recalls\n")

loess_mod=loess(y_axis ~ x_axis, span=0.3)

fortnight_pred=predict(loess_mod)

lines(x_axis, fortnight_pred, col=loess_col)

# l_mod=glm(y_axis ~ x_axis, family=quasipoisson(link="identity"))
l_mod=glm(y_axis ~ x_axis)

fortnight_pred=predict(l_mod)

lines(x_axis, orig_pred, col=pal_col[1])
lines(x_axis, fortnight_pred, col=pal_col[4])

