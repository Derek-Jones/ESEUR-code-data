#
# michael_time_to_bug.R, 18 Nov 19
#
# Data from:
# Program Analyses for Automatic and Precise Error Detection
# Michael Pradel
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Java_thread-safety test_thread-safety


source("ESEUR_config.r")


library("lattice")
library("plyr")


mean_times=function(df)
{
df$mean_time=mean(log(df$user_mode))

return(df)
}


# wallclock,user_mode,kernel_mode,class
time_bug=read.csv(paste0(ESEUR_dir, "reliability/michael_time_to_bug.csv.xz"), as.is=TRUE)

time_bug=ddply(time_bug, .(class), mean_times)

time_bug$class_num=as.numeric(as.factor(time_bug$class))

ylabs=0:5

t=bwplot(log10(user_mode) ~ reorder(as.factor(class_num), mean_time), data=time_bug,
	scales=list(y=list(at=ylabs, label=10^ylabs, cex=1.4),
		    x=list(cex=1.2)),
	panel=panel.violin,
	xlab=list(label="Fault ID", cex=1.7),
	ylab=list(label="Seconds", cex=1.7))

plot(t)

