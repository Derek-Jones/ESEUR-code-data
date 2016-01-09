#
# 10K_inputs.R 22 Dec 15
#
# Data from:
# An Experiment in Software Reliability
# Janet R. Dunham and John L. Pierce
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(1, 2)
MAX_BREW=8

brew_col=rainbow(MAX_BREW)

plot_fail_time=function(f_times, test_num)
{
#print(length(f_times))

lines(sort(f_times, na.last=TRUE), 1:25, type="b",
	col=brew_col[1+(test_num %% MAX_BREW)])
}


tests=read.csv(paste0(ESEUR_dir, "reliability/19860020075-10.csv.xz"), as.is=TRUE)

T1=subset(tests, tests$Task == 1)
T1$Task=NULL
T3=subset(tests, tests$Task == 3)
T3$Task=NULL

T3$F3=NULL
T3$F4=NULL
T3$F7=NULL
T3$F20=NULL


max_test=max(T1, na.rm=TRUE)
plot(1, log="x", type="n",
        xlim=c(1, max_test), ylim=c(1, 25),
        xlab="Input cases", ylab="",
        yaxt="n")

dummy=sapply(2:ncol(T1), function(X) plot_fail_time(T1[ , X], X))

max_test=max(T3, na.rm=TRUE)
plot(1, log="x", type="n",
        xlim=c(1, max_test), ylim=c(1, 25),
        xlab="Input cases", ylab="",
        yaxt="n")

dummy=sapply(2:ncol(T3), function(X) plot_fail_time(T3[ , X], X))

