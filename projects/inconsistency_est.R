#
# inconsistency_est.R,  9 Sep 17
# Data from:
# Inconsistency of Expert Judgement-based Estimates of Software Development Effort
# Stein Grimstad and Magne J{\o}rgensen
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")
library("reshape2")

pal_col=rainbow(6)


plot_subj=function(df)
{
# Relies on each subject being adjacent in df
points(subset(df, Order == 1)$Estimate,
       subset(df, Order == 2)$Estimate, col=pal_col[df$Task[1]])
}


incon=read.csv(paste0(ESEUR_dir, "projects/inconsistency_est.csv.xz"), as.is=TRUE)

tasks=melt(incon, measure.vars=paste0("T", 1:6),
		variable.name="Task", value.name="Estimate")

plot(0.1, type="n", log="xy",
	xlim=c(1, 80), ylim=c(1, 80),
	xlab="First estimate", ylab="Second estimate\n")

lines(c(0.5, 100), c(0.5, 100), col="grey")

d_ply(tasks, .(Task), plot_subj)

legend(x="bottomright", legend=paste0("Task ", 1:6), bty="n", fill=pal_col, cex=1.2)

First=subset(tasks, Order == 1)
Second=subset(tasks, Order == 2)

# Correlation is a misleading method of comparing accuracy
# cor.test(First$Estimate, Second$Estimate)

# Percentage difference?
# This is one of those awkward cases... TODO: switch brain
# library("boot")


