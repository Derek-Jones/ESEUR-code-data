#
# Meulen_Exp.R, 26 Dec 17
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


errs=read.csv(paste0(ESEUR_dir, "reliability/Meulen_Exp.csv.xz"), as.is=TRUE)

pal_col=rainbow(3)

plot(errs$Frequency, log="y", col=pal_col[1],
	ylim=c(1, max(errs$Frequency)),
	xlab="Error number", ylab="Occurrences\n")

points(errs$First, col=pal_col[2])
points(errs$Last, col=pal_col[3])

legend(x="topright", legend=c("Total", "First", "Last"), bty="n", fill=pal_col, cex=1.2)

