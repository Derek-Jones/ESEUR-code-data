#
# HKJEP99.R, 20 Dec 16
# Data from:
# Context Variability and Serial Position Effects in Free Recall
# Marc W. Howard and Michael J. Kahana
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


# lag,prob,low_err,high_err
rec_prob=read.csv(paste0(ESEUR_dir, "developers/HKJEP99.csv"), as.is=TRUE)


plot(rec_prob$lag[1:5], rec_prob$prob[1:5], type="b", col=point_col,
	xlim=c(-5, 5), ylim=range(rec_prob$prob),
	xlab="Lag", ylab="Recall probability\n")
lines(rec_prob$lag[6:10], rec_prob$prob[6:10], type="b", col=point_col)


