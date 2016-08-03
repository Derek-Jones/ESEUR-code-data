#
# Alemzadeh-influence.R, 17 Mar 14
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

# l_mod=glm(y_axis ~ x_axis, family=quasipoisson(link="identity"))
l_mod=glm(y_axis ~ x_axis)

influenceIndexPlot(l_mod, main="", col=point_col,
		cex.axis=0.9, cex.lab=1.0)


