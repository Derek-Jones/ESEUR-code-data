#
# Alemzadeh-Recalls.R, 17 Mar 14
#
# Data from:
# Analysis of safety-critical computer failures in medical devices
# Homa Alemzadeh and Ravishankar K. Iyer and Zbigniew Kalbarczyk and Jai Raman
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

brew_col=rainbow(3)

# Recall_Number,Date,Year,Trade_Name,Recalling_Firm,Recall_Class,Reason_Recall,Action
comp_recalls=read.csv(paste0(ESEUR_dir, "regression/Alemzadeh-Computer_Related_Recalls.csv.xz"), as.is=TRUE)

comp_recalls$Date=as.Date(comp_recalls$Date, format="%b-%d-%Y")

#recall_subset=subset(comp_recalls, Date <= as.Date("2010-12-31"))

t1=cut(comp_recalls$Date, breaks=72)
t2=table(t1)

x_axis=1:length(t2)
y_axis=as.vector(t2)
y_bounds=range(y_axis)

plot(t2, type="p", col=point_col,
	ylim=y_bounds,
	xlab="Fortnights", ylab="Reported product recalls\n")

loess_mod=loess(y_axis ~ x_axis, span=0.3)

fortnight_pred=predict(loess_mod)

lines(x_axis, fortnight_pred, col="green")

# l_mod=glm(y_axis ~ x_axis, family=quasipoisson(link="identity"))
l_mod=glm(y_axis ~ x_axis)

# l_mod=glm(y_axis ~ x_axis, family=quasipoisson(link="identity"))
l_mod=glm(y_axis ~ x_axis)

pred=predict(l_mod, se.fit=TRUE)

lines(x_axis, pred$fit, col=brew_col[1])
lines(x_axis, pred$fit+1.96*pred$se.fit, col=brew_col[3])
lines(x_axis, pred$fit-1.96*pred$se.fit, col=brew_col[3])

#influenceIndexPlot(l_mod, main="")


