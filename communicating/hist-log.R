#
# hist-log.R, 19 Nov 18
# Data from:
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example  histogram


source("ESEUR_config.r")


x=1:1e6
y=trunc(1e6/x^1.5)
log_y=log10(y)

hist(log_y, n=40, col=point_col,
	xlim=c(0, 3),
	main="", xlab="log(quantity)", ylab="Count\n")

# The following plot shows the decrease in y following a power law;
# which is the characteristic of the values assign to it.
# plot(y, log="xy")

