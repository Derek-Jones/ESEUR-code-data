#
# baddeley-barrouillet.R, 30 Dec 16
# Data from:
# Working Memory
# Alan Baddeley
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)

subj_time=read.csv(paste0(ESEUR_dir, "developers/baddeley-barrouillet.csv.xz"), as.is=TRUE)

plot(subj_time$reasoning, col=pal_col[1],
	xlab="Digit load", ylab="Reasoning time (sec)\n")


