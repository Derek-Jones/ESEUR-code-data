#
# ROC_curve.R, 13 Jul 16
#
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("ROCR")


p_n=read.csv(paste0(ESEUR_dir, "regression/ROC_curve.csv"), as.is=TRUE)


pred = prediction(p_n$score, p_n$actual)
perf=performance(pred, measure="tpr", x.measure="fpr")

plot(perf, colorize=TRUE, colorkey=FALSE,
	print.cutoffs.at=p_n$score, text.cex=1.1, text.adj=c(0, -0.5),
	xlab="False positive", ylab="True positive\n")


