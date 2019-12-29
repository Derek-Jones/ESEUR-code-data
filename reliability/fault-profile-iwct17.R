#
# fault-profile-iwct17.R, 29 Nov 19
# Data from:
# A Model for t-way Fault Profile Evolution During Testing
# D. Richard Kuhn and Raghu N. Kacker and Yu Lei
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG testing_combination faults_testing

source("ESEUR_config.r")


pal_col=rainbow(10)

ct=read.csv(paste0(ESEUR_dir, "reliability/fault-profile-iwct17.csv.xz"), as.is=TRUE)

plot (0, type="n",
	yaxs="i",
	xlim=c(1, 6), ylim=c(8, 100),
	xlab="Factor combinations", ylab="Faults experienced (percentage)\n")

dummy=sapply(2:11, function(X) lines(ct$t, ct[, X], type="b", col=pal_col[X-1]))

legend(x="bottomright", legend=names(ct)[-1], bty="n", fill=pal_col, cex=1.2)

