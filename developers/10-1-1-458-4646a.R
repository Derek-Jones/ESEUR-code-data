#
# 10-1-1-458-4646a.R, 21 Feb 19
# Data from:
# Remembering the news: {Modeling} retention data from a study with 14,000 participants
# M. Meeter and J. M. J. Murre and S. M. J. Janssen
# Experiment 1
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment human memory

source("ESEUR_config.r")


library("plyr")


pal_col=rainbow(2)


perc_correct=function(df)
{
return(mean(df$SCORE))
}

dnmt=read.csv(paste0(ESEUR_dir, "developers/10.1.1.458.4646.csv.xz"), as.is=TRUE, sep="\t")


q_4_AFC=subset(dnmt, Q_TYPE == 0)
q_open=subset(dnmt, Q_TYPE == 1)

AFC_inf=ddply(q_4_AFC, .(Q_AGE), perc_correct)
open_inf=ddply(q_open, .(Q_AGE), perc_correct)

plot(AFC_inf$Q_AGE, AFC_inf$V1, log="x", col=pal_col[1],
	ylim=c(0.20, 0.8),
	xlab="Question age (days)", ylab="Correct\n")
points(open_inf$Q_AGE, open_inf$V1, col=pal_col[2])

legend(x="bottomleft", legend=c("Forced choice: 4 alternatives", "Open"), bty="n", fill=pal_col, cex=1.2)

