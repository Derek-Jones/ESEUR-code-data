#
# lewis_andrew.R, 12 May 20
# Data from:
# A Study of Idea Generation Over Time
# Andrew Colby Lewis
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human idea_production-rate group-size

source("ESEUR_config.r")


pal_col=rainbow(3)


meth_line=function(df)
{
}


la=read.csv(paste0(ESEUR_dir, "economics/lewis_andrew.csv.xz"), as.is=TRUE)

ex1=subset(la, Experiment == 1)

plot(0, type="n",
	xlim=range(ex1$Minutes), ylim=c(5, 45),
	xlab="Minutes", ylab="Ideas\n")

legend(x="topleft", legend=c("Group=6", "Group=4", "Group=2"), bty="n", fill=pal_col, cex=1.2)

rex1=subset(ex1, Group == "Real")
nex1=subset(ex1, Group == "Nominal")

lines(rex1$Minutes, rex1$Size.2, col=pal_col[3])
lines(rex1$Minutes, rex1$Size.4, col=pal_col[2])
lines(rex1$Minutes, rex1$Size.6, col=pal_col[1])

lines(nex1$Minutes, nex1$Size.2, col=pal_col[3], lty=3)
lines(nex1$Minutes, nex1$Size.4, col=pal_col[2], lty=3)
lines(nex1$Minutes, nex1$Size.6, col=pal_col[1], lty=3)

