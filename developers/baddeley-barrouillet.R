#
# baddeley-barrouillet.R, 27 Jan 17
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

plot(subj_time$reasoning, type="b", col=pal_col[1],
	xlab="Digit load", ylab="Reasoning time (sec)\n")

par(new=TRUE)

plot(subj_time$error, col=pal_col[2],
	bty="n", xaxt="n", yaxt="n",
	ylim=c(min(subj_time$error), 2*max(subj_time$error)),
	xlab="", ylab="")

axis(4, pretty(c(min(subj_time$error), max(subj_time$error))), col=pal_col[2])

mtext("Error %", side=4, las=0, at=5, padj=3, cex=0.8)

