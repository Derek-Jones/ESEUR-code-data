#
# Hawkins1.R,  1 Mar 19
# Data from:
# Context effects in multi-alternative decision making: {Empirical} data and a Bayesian model
# Guy Hawkins and Scott D. Brown and Mark Steyvers and Eric-Jan Wagenmakers
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment human subject response-time error-rate

source("ESEUR_config.r")


library("plyr")


plot_layout(2, 1)


# Exclude participants with mean accuracy less than excludeMeanAccuracyBelow
# or whose computer displayed less than an average of 13 time steps per second
subject_ok=function(df)
{
if ((mean(df$WinningBucket == df$SelectedBucket) >= excludeMeanAccuracyBelow) &&
	(mean(df$avFramerate) >= 13))
   {
   # Count setP rows that are not -1
   df$N=rowSums(apply(subset(df, select=grepl("setP", colnames(df))), 2,
							function(X) (X != -1)))
   return(df)
   }
return(NULL)
}


# Mean response time, by subject and number of choices
rts_mean_subject=function(df)
{
return(mean(df$GameTime))
}


# Mean accuracy, by subject and number of choices
acc_mean_subject=function(df)
{
return(mean(df$WinningBucket == df$SelectedBucket))
}


plot_subj_perf=function(df, ylab_str)
{
u_subj=unique(df$Subject)
pal_col=rainbow(length(u_subj))

# Sort subjects by performance, based on N==2
N2=subset(df, N == 2)

df$col_str=mapvalues(df$Subject, u_subj[order(N2$V1)],
					pal_col)

plot(df$N, df$V1, log="x", col=df$col_str,
	xlab="Number of alternatives", ylab=ylab_str)

# rts_mod=glm(V1 ~ log(N)+Subject, data=df)
rts_mod=glm(V1 ~ log(N), data=df)
# summary(rts_mod)

pred=predict(rts_mod, newdata=data.frame(N=2:20), se.fit=TRUE)
lines(2:20, pred$fit, col="black")
lines(2:20, pred$fit+1.96*pred$se.fit, col="yellow")
lines(2:20, pred$fit-1.96*pred$se.fit, col="yellow")
}


haw=read.csv(paste0(ESEUR_dir, "developers/Hawkins1.csv.xz"), as.is=TRUE)


# mean accuracy exclusion criterion
excludeMeanAccuracyBelow=.45


ok_subj=ddply(haw, .(Subject), subject_ok)
rts_subj_m=ddply(ok_subj, .(Subject, N), rts_mean_subject)
acc_subj_m=ddply(ok_subj, .(Subject, N), acc_mean_subject)

plot_subj_perf(rts_subj_m, "Response time (secs)\n")
plot_subj_perf(acc_subj_m, "Accuracy\n")

