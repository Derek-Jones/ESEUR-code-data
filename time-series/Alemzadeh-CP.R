#
# Alemzadeh-CP.R, 25 Sep 18
#
# Data from:
# Analysis of safety-critical computer failures in medical devices
# Homa Alemzadeh and Ravishankar K. Iyer and Zbigniew Kalbarczyk and Jai Raman
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG change-point medical hardware failure


source("ESEUR_config.r")

library("changepoint")


plot_layout(2, 1)

pal_col=rainbow(2)

# Recall_Number,Date,Year,Trade_Name,Recalling_Firm,Recall_Class,Reason_Recall,Action
comp_recalls=read.csv(paste0(ESEUR_dir, "regression/Alemzadeh-Computer_Related_Recalls.csv.xz"), as.is=TRUE)

comp_recalls$Date=as.Date(comp_recalls$Date, format="%b-%d-%Y")

#recall_subset=subset(comp_recalls, Date <= as.Date("2010-12-31"))

t1=cut(comp_recalls$Date, breaks=72)
t2=table(t1)

# change_at=cpt.mean(as.vector(t2), test.stat="CUSUM", penalty="Manual", pen.value="log(n"))
change_at=cpt.mean(as.vector(t2))
plot(change_at, col=pal_col[2], cpt.col=pal_col[1],
	xlab="", ylab="Reported product recalls\n")

change_at=cpt.mean(as.vector(t2), method="PELT")
plot(change_at, col=pal_col[2], cpt.col=pal_col[1],
	xlab="Fortnights", ylab="Reported product recalls\n")


