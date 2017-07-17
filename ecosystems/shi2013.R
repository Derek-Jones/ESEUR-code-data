#
# shi2013.R, 16 May 17
# Data from:
# Learning from Evolution History to Predict Future Requirement Changes
# Lin Shi and Qing Wang and Mingshu Li
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

pal_col=rainbow(4)


shi=read.csv(paste0(ESEUR_dir, "ecosystems/shi2013.csv.xz"), as.is=TRUE)

plot(shi$Total, col=pal_col[1], yaxs="i",
	ylim=c(0, max(shi$Total)+5),
	xlab="Version", ylab="Requirements\n")
lines(shi$Added, col=pal_col[2])
lines(shi$Modified, col=pal_col[3])
lines(shi$Deleted, col=pal_col[4])

legend(x="right", legend=c("Total", "Added", "Modified", "Deleted"), bty="n", fill=pal_col, cex=1.2)

