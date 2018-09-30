#
# Alemzadeh-chngpt.R, 29 Sep 18
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


library("chngpt")


pal_col=rainbow(4)

# Recall_Number,Date,Year,Trade_Name,Recalling_Firm,Recall_Class,Reason_Recall,Action
comp_recalls=read.csv(paste0(ESEUR_dir, "regression/Alemzadeh-Computer_Related_Recalls.csv.xz"), as.is=TRUE)

comp_recalls$Date=as.Date(comp_recalls$Date, format="%b-%d-%Y")

t1=cut(comp_recalls$Date, breaks=72)
t2=table(t1)

x_axis=1:length(t2)
y_axis=as.vector(t2)
y_bounds=range(y_axis)

# l_mod=glm(y_axis ~ x_axis, family=quasipoisson(link="identity"))
l_mod=glm(y_axis ~ x_axis)
orig_pred=predict(l_mod)

t2[33]=round(mean(y_axis))
#t2[34]=round(mean(y_axis))
t2[67]=round(mean(y_axis))
y_axis=as.vector(t2)
y_bounds=range(y_axis)

plot(t2, type="p", col=pal_col[3],
	ylim=y_bounds,
	xlab="Fortnights", ylab="Recalls")

# Just fit everything before the send of 2010
recall_subset=subset(comp_recalls, Date <= as.Date("2010-12-31"))

t1=cut(comp_recalls$Date, breaks=60)
t2=table(t1)

bined_recalls=data.frame(fortnight=1:length(t2), recalls=as.vector(t2))

fit=chngptm(recalls ~ 1, ~fortnight, family="gaussian", data=bined_recalls,
#		type="stegmented",
		type="segmented",
		var.type="bootstrap", save.boot=TRUE)

plot(fit, which=1)


