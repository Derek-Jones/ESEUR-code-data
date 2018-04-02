#
# 10K_inputs.R 23 Feb 18
#
# Data from:
# An Experiment in Software Reliability
# Janet R. Dunham and John L. Pierce
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("reshape2")

# plot_layout(2, 1)

pal_col=rainbow(8)


plot_fails=function(df)
{
pal_col=rainbow(max(df$failure))
# plot(df$F, df$id, log="x", col=pal_col[df$failure],
# 	xlab="Input cases", ylab="Replication")

plot(1, type="n", log="x",
	xlim=range(df$F, na.rm=TRUE), ylim=range(df$id),
	xlab="Input cases", ylab="Replication")

dummy=sapply(1:max(df$failure), function(X)
                {
                t=subset(df, failure == X)
                lines(t$F, t$id, col=pal_col[t$failure])
                })
}

mean_sd=function(df)
{
dummy=sapply(1:8, function(X)
                {
                t=subset(df, failure == X)
                print(c(mean(log(t$F), na.rm=TRUE),
                		sd(log(t$F), na.rm=TRUE)))
                })
}


tests=read.csv(paste0(ESEUR_dir, "reliability/19860020075-10.csv.xz"), as.is=TRUE)

T1=subset(tests, tests$Task == 1)
T1$Task=NULL
T1$Rep=NULL
# Only occur because the columns are needed for the T3 results
T1$F9=NULL
T1$F10=NULL; T1$F11=NULL; T1$F12=NULL; T1$F13=NULL; T1$F14=NULL; T1$F15=NULL;
T1$F16=NULL; T1$F17=NULL; T1$F18=NULL; T1$F19=NULL; T1$F20=NULL

T3=subset(tests, tests$Task == 3)
T3$Task=NULL
T3$Rep=NULL

# These 'fixes' were not real mistakes
T3$F3=NULL
T3$F4=NULL
T3$F7=NULL
T3$F20=NULL


T1_fails=reshape(T1, varying=colnames(T1), timevar="failure", dir="long", sep="")
plot_fails(T1_fails)
# mean_sd(T1_fails)


# T3_fails=reshape(T3, varying=colnames(T3), timevar="failure", dir="long", sep="")
# plot_fails(T3_fails)
# mean_sd(T3_fails)


