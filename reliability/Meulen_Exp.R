#
# Meulen_Exp.R, 21 Nov 19
# Data from:
# An Exploration of Software Faults and Failure Behaviour in a Large Population of Programs
# M. J. P. {van der Meulen} and P. G. Bishop and M. Revilla
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG fault_output program_output


source("ESEUR_config.r")


pal_col=rainbow(3)

errs=read.csv(paste0(ESEUR_dir, "reliability/Meulen_Exp.csv.xz"), as.is=TRUE)

plot(errs$Frequency, log="y", col=pal_col[1],
	ylim=c(1, max(errs$Frequency)),
	xlab="Error number", ylab="Occurrences\n")

points(errs$First, col=pal_col[2])
points(errs$Last, col=pal_col[3])

legend(x="topright", legend=c("Total", "First", "Last"), bty="n", fill=pal_col, cex=1.2)

