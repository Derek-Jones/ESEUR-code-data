#
# hogarth92.R, 22 Feb 19
# Data from:
# Learning From Feedback: {Exactness} and Incentives
# Robin M. Hogarth and Craig R. M. McKenzie and Brian J. Gibbs and Margaret A. Marquis
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment human belief learning


source("ESEUR_config.r")


set_width_height(max_width=8, max_height=12)
plot_layout(3, 2)
par(mar=c(2.2, 2.5, 1, 0.5))
par(cex.lab=1.5)


pal_col=rainbow(2)

plot(0, type="n", xaxp=c(0, 2, 2),
	xaxt="n",
	xlim=c(0, 2), ylim=c(60, 90),
	xlab="", ylab="Belief")
axis(1, at=c(0, 2), label=c("Start", "End"))
text(1, 90, "Step-by-Step", cex=1.2)
lines(c(0, 1, 2), c(63.0, 78.1, 81.2), type="b", col=pal_col[1])
lines(c(0, 1, 2), c(68.2, 72.7, 83.7), type="b", col=pal_col[2])
legend(x="bottomright", legend=c("Strong-Weak", "Weak-Strong"), bty="n", fill=pal_col, cex=1.2)

plot(0, type="n", xaxp=c(0, 2, 2),
	xaxt="n",
	xlim=c(0, 2), ylim=c(30, 70),
	xlab="", ylab="Belief")
axis(1, at=c(0, 2), label=c("Start", "End"))
text(1, 70, "Step-by-Step", cex=1.2)
lines(c(0, 1, 2), c(68.1, 55.1, 35.8), type="b", col=pal_col[1])
lines(c(0, 1, 2), c(68.3, 41.1, 35.8), type="b", col=pal_col[2])
legend(x="bottomright", legend=c("Weak-Strong", "Strong-Week"), bty="n", fill=pal_col, cex=1.2)

plot(0, type="n", xaxp=c(0, 2, 2),
	xaxt="n",
	xlim=c(0, 2), ylim=c(40, 85),
	xlab="", ylab="Belief")
axis(1, at=c(0, 2), label=c("Start", "End"))
text(1, 85, "Step-by-Step", cex=1.2)
lines(c(0, 1, 2), c(69.2, 82.6, 62.7), type="b", col=pal_col[1])
lines(c(0, 1, 2), c(68.6, 43.6, 75.7), type="b", col=pal_col[2])
legend(x="bottomright", legend=c("Positive-Negative", "Negative-Positive"), bty="n", fill=pal_col, cex=1.2)


plot(0, type="n", xaxp=c(0, 2, 2),
	xaxt="n", yaxt="n",
	xlim=c(0, 2), ylim=c(60, 90),
	xlab="", ylab="")
axis(1, at=c(0, 2), label=c("Start", "End"))
text(1, 90, "End-of-Sequence", cex=1.2)
lines(c(0, 2), c(67.1, 79.1), type="b", col=pal_col[1])
lines(c(0, 2), c(67.2, 83.3), type="b", col=pal_col[2])
legend(x="bottomright", legend=c("Strong-Weak", "Weak-Strong"), bty="n", fill=pal_col, cex=1.2)

plot(0, type="n", xaxp=c(0, 2, 2),
	xaxt="n", yaxt="n",
	xlim=c(0, 2), ylim=c(30, 70),
	xlab="", ylab="")
axis(1, at=c(0, 2), label=c("Start", "End"))
text(1, 70, "End-of-Sequence", cex=1.2)
lines(c(0, 2), c(67.3, 50.0), type="b", col=pal_col[1])
lines(c(0, 2), c(64.7, 40.6), type="b", col=pal_col[2])
legend(x="bottomright", legend=c("Weak-Strong", "Strong-Week"), bty="n", fill=pal_col, cex=1.2)

plot(0, type="n", xaxp=c(0, 2, 2),
	xaxt="n", yaxt="n",
	xlim=c(0, 2), ylim=c(40, 85),
	xlab="", ylab="")
axis(1, at=c(0, 2), label=c("Start", "End"))
text(1, 85, "End-of-Sequence", cex=1.2)
lines(c(0, 2), c(71.5, 59.1), type="b", col=pal_col[1])
lines(c(0, 2), c(70.8, 69.6), type="b", col=pal_col[2])
legend(x="bottomright", legend=c("Positive-Negative", "Negative-Positive"), bty="n", fill=pal_col, cex=1.2)



