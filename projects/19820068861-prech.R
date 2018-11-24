#
# 19820068861-prech.R, 20 Nov 18
# Data from:
# EXPERIMENTAL RESULTS ON SOFTWARE DEBUGGING
# Sylvia B. Sheppard and Phil Milliman and Bill Curtis
# via Lutz Prechelt (pretest data, not experiment 3 data)
#
# For pretest details, see:
# Substantiating Programmer Variability
# Bill Curtis
# PROCEEDINGS OF THE IEEE, VOL. 69, NO. 7, JULY 1981

# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment developers fault-finding

source("ESEUR_config.r")


library("boot")


boot_all=function(t1_sample, indices)
{
# The number of subjects is 27, pair two lots of 16
return(mean(ifelse(t1_sample[indices[1:13]]<t1_sample[indices[14:26]],
                   t1_sample[indices[1:13]], t1_sample[indices[14:26]])))
}

pair_all=function()
{
# The number of subjects is 27, pair two lots of 16
p1=sample(1:t1_len)
return(mean(ifelse(t1$time[p1[1:13]]<t1$time[p1[14:26]],
                   t1$time[p1[1:13]], t1$time[p1[14:26]])))
}


ftime=read.csv(paste0(ESEUR_dir, "projects/19820068861-prech.csv.xz"), as.is=TRUE)

t1=subset(ftime, task == "t1")
t2=subset(ftime, task == "t2")

t1_len=nrow(t1)

mean(t1$time)
sd(t1$time)

plot(density(t1$time, from=1, to=60), col=point_col, main="",
	xaxs="i",
	xlim=c(0, 60),
	xlab="Time taken", ylab="Density\n")

pair_mean=boot(t1$time, boot_all, R=9999)
boot.ci(pair_mean)


a_pair=replicate(9999, pair_all())

mean(a_pair)
sd(a_pair)


