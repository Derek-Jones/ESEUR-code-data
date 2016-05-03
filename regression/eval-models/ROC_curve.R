#
# ROC-curve.R, 23 Sep 11
#
# Example data from "An introduction to ROC analysis" by Tom Fawcett

source("config.r")

plot_layout(1, 2)

TP_FP_point = function(cur_score)
{
c(length(which(p_n[p_n$class=="n", ]$score >= cur_score))/num_FP,
  length(which(p_n[p_n$class=="p", ]$score >= cur_score))/num_TP)
}

p_n=read.csv(paste0(root, "models/eval-models/AUC-curve.data"), as.is=TRUE)

# Send table of value to plot on the left
# yet to write this code.
# + graphical representation on the right

num_TP=length(which(p_n$class == "p"))
num_FP=length(which(p_n$class == "n"))

ROC_points=sapply(p_n$score, TP_FP_point)

plot(ROC_points[1,], ROC_points[2,], type="b",
     xlab="False Positive rate",
     ylab="True Positive rate", ylim=c(0.0,1.0))
text(ROC_points[1,], ROC_points[2,], labels=p_n$score, cex=0.8, adj=c(0,-1))


