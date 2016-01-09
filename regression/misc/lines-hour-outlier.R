#
# lines-hour-outlier.R, 16 Mar 14
#
# Data from:
# On the effectiveness of early life cycle defect prediction with Bayesian Nets
# Norman Fenton and Martin Neil and William Marsh and Peter Hearty and {\L}ukasz Radli\'{n}ski and Paul Krause
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library(car)

brew_col=rainbow(3)

plot_layout(1, 2)

loc_hour=read.csv(paste0(ESEUR_dir, "regression/10.1.1.157.6206.csv.xz"), as.is=TRUE)
loc_hour=subset(loc_hour, !is.na(KLoC))
loc_hour=loc_hour[order(loc_hour$KLoC), ]
# cook.levels uses row.names and it is confusing because the original ones
# are maintained from before: loc_hour[order(loc_hour$KLoC), ]
row.names(loc_hour)=1:nrow(loc_hour)

x_bounds=range(loc_hour$Hours)
y_bounds=range(loc_hour$KLoC)

Hours_KLoC=function(df)
{
plot(df$Hours, df$KLoC,
	xlim=x_bounds, ylim=y_bounds,
	xlab="Hours", ylab="Lines of code (Kloc)")

plh_mod=glm(KLoC ~ Hours, data=df)

plh_pred=predict(plh_mod, type="response", se.fit=TRUE)

lines(df$Hours, plh_pred$fit, col=brew_col[1])
lines(df$Hours, plh_pred$fit+plh_pred$se.fit*1.96, col=brew_col[3])
lines(df$Hours, plh_pred$fit-plh_pred$se.fit*1.96, col=brew_col[3])

return(plh_mod)
}

plot_cutoff=function(df, model)
{
cutoff=4/(nrow(df)+1+1)
plot(model, which=4, cook.levels=cutoff, caption="")
abline(h=cutoff, lty=2, col="red")
}


all_mod=Hours_KLoC(loc_hour)
# plot_cutoff(loc_hour, all_mod)

s1_loc_hour=loc_hour[-c(21,25,29),]
# subset1_mod=Hours_KLoC(s1_loc_hour)
# plot_cutoff(s1_loc_hour, subset1_mod)
# 
# influenceIndexPlot(all_mod)

s2_loc_hour=s1_loc_hour[-c(23,24,26),]
# subset2_mod=Hours_KLoC(s2_loc_hour)
# plot_cutoff(s2_loc_hour, subset2_mod)

s3_loc_hour=s2_loc_hour[-c(19,23),]
# subset3_mod=Hours_KLoC(s3_loc_hour)
# plot_cutoff(s3_loc_hour, subset3_mod)

s4_loc_hour=s3_loc_hour[-c(4,19,20),]
# subset4_mod=Hours_KLoC(s4_loc_hour)
# plot_cutoff(s4_loc_hour, subset4_mod)

s5_loc_hour=s4_loc_hour[-c(17),]
# subset5_mod=Hours_KLoC(s5_loc_hour)
# plot_cutoff(s5_loc_hour, subset5_mod)

s6_loc_hour=s5_loc_hour[-c(17),]
# subset6_mod=Hours_KLoC(s6_loc_hour)
# plot_cutoff(s6_loc_hour, subset6_mod)

s7_loc_hour=s6_loc_hour[-c(12,14),]
# subset7_mod=Hours_KLoC(s7_loc_hour)
# plot_cutoff(s7_loc_hour, subset7_mod)

s8_loc_hour=s7_loc_hour[-c(12),]
# subset8_mod=Hours_KLoC(s8_loc_hour)
# plot_cutoff(s8_loc_hour, subset8_mod)

s9_loc_hour=s8_loc_hour[-c(12),]
# subset9_mod=Hours_KLoC(s9_loc_hour)
# plot_cutoff(s9_loc_hour, subset9_mod)

s10_loc_hour=s9_loc_hour[-c(12),]
subset10_mod=Hours_KLoC(s10_loc_hour)
# plot_cutoff(s10_loc_hour, subset10_mod)


# 
# outlierTest(all_mod)
# influencePlot(all_mod)
# 
# 
# library(robustbase)
# 
# rlh_mod=glmrob(Hours ~ KLoC, family=gaussian, data=loc_hour)

