#
# code-review-cisco.R, 12 Nov 18
# Data from:
# Jason Cohen and Steven Teleki and Eric Brown
# Best Kept Secrets of Peer Code Review
#
# Data extracted from pdf
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG code-review LOC time

source("ESEUR_config.r")


pal_col=rainbow(3)


cisco=read.csv(paste0(ESEUR_dir, "data-check/code-review-cisco.csv.xz"), as.is=TRUE)

cisco=subset(cisco, LOC > 0)

plot(cisco$LOC, 60*cisco$LOC/cisco$LOC.Hr, log="xy", col=point_col,
	yaxs="i",
	xlim=c(1, 1e6), ylim=c(0.1, 5e2),
	xlab="LOC", ylab="Review time (minutes)\n")

lines(c(2e3, 2e3), c(1e-3, 1e3), col=pal_col[1])

lines(c(1e-2, 1e6), c(0.5, 0.5), col=pal_col[2])

# Max rate of review, 1500 lines per hour
x_loc=c(1e-2, 1e6)
lines(x_loc, 60*x_loc/1500, col=pal_col[3])

