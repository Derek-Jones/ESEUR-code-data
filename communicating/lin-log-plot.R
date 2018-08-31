#
# lin-log-plot.R, 22 Feb 18
#
# Data from:
# An Experiment in Software Reliability
# Janet R. Dunham and John L. Pierce
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG reliability experiment input


source("ESEUR_config.r")


library("reshape2")


plot_layout(2, 1)

pal_col=rainbow(4)


tests=read.csv(paste0(ESEUR_dir, "reliability/19860020075-500.csv.xz"), as.is=TRUE)
tests$Code=NULL
tests$Rep=NULL

all_fails=reshape(tests, varying=colnames(tests), timevar="failure", dir="long", sep="")

plot(1, type="n",
	xlim=range(all_fails$F, na.rm=TRUE), ylim=range(all_fails$failure, na.rm=TRUE),
	xlab="Input cases", ylab="Failure")

dummy=sapply(1:4, function(X)
		{
		t=subset(all_fails, id == X)
		lines(t$F, t$failure, col=pal_col[t$id])
		})


plot(1, type="n", log="x",
	xlim=range(all_fails$F, na.rm=TRUE), ylim=range(all_fails$failure, na.rm=TRUE),
	xlab="Input cases", ylab="Failure")

dummy=sapply(1:4, function(X)
		{
		t=subset(all_fails, id == X)
		lines(t$F, t$failure, col=pal_col[t$id])
		})


