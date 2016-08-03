#
# 500K_inputs.R, 15 Jul 16
#
# Data from:
# An Experiment in Software Reliability
# Janet R. Dunham and John L. Pierce
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(2, 1)

plot_test=function(test_num)
{
lines(tests[test_num, ], 1:ncol(tests), col=brew_col[test_num])
}


tests=read.csv(paste0(ESEUR_dir, "reliability/19860020075-500.csv.xz"), as.is=TRUE)

tests$Code=NULL
tests$Rep=NULL

max_test=max(tests[1:4, ], na.rm=TRUE)

brew_col=rainbow(4)

plot(1, type="n",
	xlim=c(1, max_test), ylim=c(1, ncol(tests)),
	xlab="Input cases", ylab="Failure count")
dummy=sapply(1:4, plot_test)


plot(1, log="x", type="n",
	xlim=c(1, max_test), ylim=c(1, ncol(tests)),
	xlab="Input cases", ylab="")
dummy=sapply(1:4, plot_test)


