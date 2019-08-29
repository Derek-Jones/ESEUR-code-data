#
# CSD-95-887.R, 10 Aug 19
# Data from:
# Exploiting Process Lifetime Distributions for Dynamic Load Balancing
# Mor Harchol-Balter and Allen B. Downey
# 
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG

source("ESEUR_config.r")


library("plyr")


CSD=read.csv(paste0(ESEUR_dir, "ecosystems/CSD-trace.csv.xz"), as.is=TRUE)

time_cnt=count(CSD$sec)

plot(time_cnt$x, time_cnt$freq, log="xy", col=point_col,
	xlab="Execution time (sec)", ylab="Processes\n")

