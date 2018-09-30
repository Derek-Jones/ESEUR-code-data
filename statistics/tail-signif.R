#
# tail-signif.R, 16 Jul 16
# Data from:
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example


source("ESEUR_config.r")


plot_layout(2, 1)
par(mar=c(5, 1, 4, 1)+0.1)

pal_col=rainbow(3)


norm_mean=4
norm_sd=1

xpoints=seq(0, norm_mean+norm_sd*4, by=0.01)
ypoints=dnorm(xpoints, mean=norm_mean, sd=norm_sd)

qn=qnorm(c(0.975, 0.95), 0, norm_sd)

max_y=max(ypoints)

# Two-tailed significance test
plot(xpoints, ypoints, type="l", col=pal_col[3], fg="grey", col.axis="grey", yaxt="n",
	bty="n", yaxt="n",
	xlab="Two-tailed", ylab="")
q=c(norm_mean-qn[1], norm_mean+qn[1])
lines(c(q[1], q[1]), c(0, max_y), col=pal_col[1])
lines(c(q[2], q[2]), c(0, max_y), col=pal_col[1])

upper_y=subset(ypoints, xpoints <= norm_mean-qn[1])
upper_x=subset(xpoints, xpoints <= norm_mean-qn[1])
polygon(c(upper_x,  norm_mean-qn[1], 0), c(upper_y, 0, 0), col=pal_col[2])

upper_y=subset(ypoints, xpoints >= norm_mean+qn[1])
upper_x=subset(xpoints, xpoints >= norm_mean+qn[1])
polygon(c(upper_x,  norm_mean+qn[1]), c(upper_y, 0), col=pal_col[2])

text(norm_mean, max_y/1.5, "Fail to reject\nnull hypothesis", cex=1.4)
text(norm_mean-norm_sd*2.0, max_y/3, "Reject null\nhypothesis", pos=2, cex=1.4)
text(norm_mean+norm_sd*2.0, max_y/3, "Reject null\nhypothesis", pos=4, cex=1.4)


# One-tailed significance test
plot(xpoints, ypoints, type="l", col=pal_col[3], fg="grey", col.axis="grey", yaxt="n",
	bty="n", yaxt="n",
	xlab="One-tailed", ylab="")
q=norm_mean+qn[2]
lines(c(q[1], q[1]), c(0, max_y), col=pal_col[1])

upper_y=subset(ypoints, xpoints >= norm_mean+qn[2])
upper_x=subset(xpoints, xpoints >= norm_mean+qn[2])
polygon(c(upper_x,  norm_mean+qn[2]), c(upper_y, 0), col=pal_col[2])

text(norm_mean-1.3, max_y/1.5, "Fail to reject null hypothesis", cex=1.4)
text(norm_mean+norm_sd*1.7, max_y/3, "Reject null\nhypothesis", pos=4, cex=1.4)

