#
# iwsc2011-kamiya.R, 27 Dec 17
# Data from:
# How Code Skips Over Revisions
# Toshihiro Kamiya
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


added=read.csv(paste0(ESEUR_dir, "sourcecode/iwsc2011-kamiya.csv.xz"), as.is=TRUE)

reuse=subset(added, delta > 0)

plot(as.vector(table(reuse$delta)), log="y", col=point_col,
	xlim=c(1, 100), ylim=c(10, 1e3),
	xlab="Revision delta", ylab="Instances\n")

plot(as.vector(table(reuse$added)), log="y", col=point_col,
	xlim=c(1, 100), ylim=c(10, 1e5),
	xlab="Reused lines", ylab="Instances\n")

plot(reuse$delta, reuse$added, log="xy", col=point_col,
	xlim=c(1, 1e2), ylim=c(1, 1e2),
	xlab="Revision delta", ylab="Lines added\n")

reuse_100=subset(reuse, delta <= 100 && added <= 100)

smoothScatter(reuse_100$delta, reuse_100$added, log="xy", col=point_col,
	xlim=c(2, 100), ylim=c(1, 25),
	xlab="Revision delta", ylab="Lines reused\n")


