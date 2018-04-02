#
# michael_time_to_bug.R, 29 Dec 17
#
# Data from:
# Program Analyses for Automatic and Precise Error Detection
# Michael Pradel
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


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
	scales=list(y=list(at=ylabs, label=10^ylabs)),
	panel=panel.violin,
	xlab="Fault", ylab="Seconds")

plot(t)

