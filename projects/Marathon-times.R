#
# Marathon-times.R, 24 May 20
# Data from:
# Reference-Dependent Preferences: {Evidence} from Marathon Runners
# Eric J. Allen and Patricia M. Dechow and Devin G. Pope and George Wu
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG human_performance marathon_finish-times


source("ESEUR_config.r")


library("plyr")


# A random sample of 250,000 from the original 9 million
ct=read.csv(paste0(ESEUR_dir, "projects/Marathon-times.csv.xz"), as.is=TRUE)

t_freq=count(round(ct$chiptime))

plot(t_freq, col=point_col, type="l",
	xaxs="i", yaxs="i",
	xlim=c(170, 320),
	xlab="Finish time (minutes)", ylab="Competitors\n")

