#
# baddeley-barrouillet.R, 13 Oct 20
# Data from:
# Working Memory
# Alan Baddeley
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human memory_human


source("ESEUR_config.r")


pal_col=rainbow(2)

subj_time=read.csv(paste0(ESEUR_dir, "developers/baddeley-barrouillet.csv.xz"), as.is=TRUE)

# No option to just draw the x-axis
plot(subj_time$reasoning, type="b", col=pal_col[1],
	yaxt="n",
	xlab="Digit load", ylab="Reasoning time (sec)\n")

axis(2, pretty(c(min(subj_time$reasoning), max(subj_time$reasoning))), col=pal_col[1])

par(new=TRUE)

plot(subj_time$error, col=pal_col[2],
	bty="n", xaxt="n", yaxt="n",
	ylim=c(min(subj_time$error), 2*max(subj_time$error)),
	xlab="", ylab="")

axis(4, pretty(c(min(subj_time$error), max(subj_time$error))), col=pal_col[2])
mtext("Error %", side=4, las=0, at=5, padj=3, cex=0.8)

