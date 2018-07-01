#
# round_prob.R, 23 Apr 18
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

pal_col=rainbow(4)


# Formula from:
# Harald A. Bastiaanse
# Very, Many, Small, {Penguins}: {Vaguely} Related Topics
speaker_rounded=function(k)
{
return(k/(k+(1/x)-1))
}


x=seq(0.05, 0.9, by=0.05)

plot(x, speaker_rounded(2), type="l", col=pal_col[4],
	ylim=c(0.1, 1.0),
	xlab="Estimate that speaker rounded", ylab="Probability speaker actually rounded\n")
lines(x, speaker_rounded(4), col=pal_col[3])
lines(x, speaker_rounded(6), col=pal_col[2])
lines(x, speaker_rounded(8), col=pal_col[1])

lines(c(0, 1), c(0.5, 0.5), col="grey")

legend(x="bottomright", legend=c("k=8", "k=6", "k=4", "k=2"), bty="n", fill=pal_col, cex=1.2)

