#
# abc13.R, 25 Mar 17
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(3)

abc=read.csv(paste0(ESEUR_dir, "developers/abc13.csv.xz"), as.is=TRUE)

plot(0, type="n", bty="n",
	xaxt="n", yaxt="n",
	xlim=c(0, 1), ylim=c(-0.3, 0.7),
	xlab="", ylab="")

# 12
lines(abc[1:8,], col=point_col)
lines(abc[9:26,], col=point_col)

# 13
lines(abc[27:36,], col=point_col)
lines(abc[37:55,], col=point_col)

# 14
lines(abc[56:65,], col=point_col)
lines(abc[66:81,], col=point_col)
lines(abc[82:94,], col=point_col)

# A
lines(abc$x[95:116]+0.28, abc$y[95:116]-0.07, col=point_col)
lines(abc$x[117:121]+0.28, abc$y[117:121]-0.07, col=point_col)

# B
# lines(abc$x[27:36]-0.05, abc$y[27:36]+0.44, col=point_col)
# lines(abc$x[37:55]-0.05, abc$y[37:55]+0.44, col=point_col)

# C
lines(abc$x[122:nrow(abc)]-0.19, abc$y[122:nrow(abc)]-0.78, col=point_col)

