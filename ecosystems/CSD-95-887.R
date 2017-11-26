#
# CSD-95-887.R,  5 Jul 17
# Data from:
# Exploiting Process Lifetime Distributions for Dynamic Load Balancing
# Mor Harchol-Balter and Allen B. Downey
# 
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


CSD=read.csv(paste0(ESEUR_dir, "ecosystems/CSD-trace.csv.xz"), as.is=TRUE)

time_cnt=as.data.frame(table(CSD$sec), stringsAsFactors=FALSE)

plot(time_cnt$Var1, time_cnt$Freq, log="xy", col=point_col,
	xlab="Execution time (sec)", ylab="Processes\n")

