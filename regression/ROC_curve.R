#
# ROC_curve.R, 22 May 20
#
# Data from:
# Example
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example_ROC-curve


source("ESEUR_config.r")


library("ROCR")


p_n=read.csv(paste0(ESEUR_dir, "regression/ROC_curve.csv.xz"), as.is=TRUE)

pred = prediction(p_n$score, p_n$actual)
perf=performance(pred, measure="tpr", x.measure="fpr")

plot(perf, colorize=TRUE, colorkey=FALSE,
	print.cutoffs.at=p_n$score, text.cex=1.1, text.adj=c(0, -0.5),
	yaxs="i",
	xlim=c(0, 1.06), ylim=c(0, 1.05),
	xlab="False positive", ylab="True positive\n")


