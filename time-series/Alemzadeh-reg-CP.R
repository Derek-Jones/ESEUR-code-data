#
# Alemzadeh-reg-CP.R, 16 Mar 20
#
# Data from:
# Analysis of safety-critical computer failures in medical devices
# Homa Alemzadeh and Ravishankar K. Iyer and Zbigniew Kalbarczyk and Jai Raman
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG change-point medical_hardware hardware_failure


source("ESEUR_config.r")

library("plyr")
library("segmented")


pal_col=rainbow(3)

# Recall_Number,Date,Year,Trade_Name,Recalling_Firm,Recall_Class,Reason_Recall,Action
comp_recalls=read.csv(paste0(ESEUR_dir, "regression/Alemzadeh-Computer_Related_Recalls.csv.xz"), as.is=TRUE)

comp_recalls$Date=as.Date(comp_recalls$Date, format="%b-%d-%Y")

#recall_subset=subset(comp_recalls, Date <= as.Date("2010-12-31"))

t1=cut(comp_recalls$Date, breaks=72)
t2=count(t1)
t2$fortnight=1:nrow(t2)

plot(t2$fortnight, t2$freq, type="l", col=pal_col[2],
	xaxs="i",
	xlab="Fortnights", ylab="Reported product recalls\n")

al_mod=glm(freq ~ fortnight, data=t2) # fit model as usual

pred=predict(al_mod)
lines(pred, col=pal_col[3]) # add fitted line to plot

# npsi=2 has a different take on what happens after the first change-point
seg_mod=segmented(al_mod, npsi=1) # adjust fitted model with one change-point

plot(seg_mod, col=pal_col[1], add=TRUE) # add fitted lines to plot

