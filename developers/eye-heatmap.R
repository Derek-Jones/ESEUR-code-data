#
# eye-heatmap.R, 12 Jan 17
#
# Data from:
# An Empirical Study on Requirements Traceability Using Eye-Tracking
# Nasir Ali and Zohreh Sharafi and Yann-Ga{\"e}l Gu{\'e}h{\'e}neuc and Giuliano Antoniol
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

# Thanks to Tarn Diong for showing how to use kde...

source("ESEUR_config.r")


library("png")
library("ks")

# plot_wide()


prob2=readPNG(paste0(ESEUR_dir, "developers/2.png"), TRUE)
subject06=read.csv(paste0(ESEUR_dir, "developers/subject06.csv.xz"), as.is=TRUE)

# Each pixel is a possible gaze location
xbounds=c(1, ncol(prob2))
ybounds=c(1, nrow(prob2))

par(mar=c(0,0,0,0))
plot(1, type="n",
	xlim=xbounds, ylim=ybounds,
	xlab="x", ylab="y")

rasterImage(prob2, xbounds[1], ybounds[1], xbounds[2], ybounds[2])

points(subject06$x, ybounds[2]-subject06$y, pch=16, cex=0.5)

# draw lines between saccade points
# lines(subject06$x, ybounds[2]-subject06$y)

ts=na.omit(subject06)
xy=cbind(ts$x, ybounds[2]-ts$y)

fhat=kde(xy, compute.cont=TRUE)
col=c("transparent", rainbow(99, alpha=0.03))
plot(fhat, add=TRUE, display="filled.contour2", cont=1:99, col=col)
points(fhat$x, cex=0.5, pch=16)


# library("feature")
# 
# fs=featureSignif(xy)

# points(fs)

# 
# eye_contour=matrix(data=0, nrow=nrow(prob2), ncol=ncol(prob2))
# ts=na.omit(subject06)
# dummy=sapply(1:nrow(ts), function(X)
# 			{
# Yay, a global variable
# 			eye_contour[ts$y[X], ts$x[X]] <<-
# 				eye_contour[ts$y[X], ts$x[X]]+
# 				ts$Time[X]
# 			})

# There are duplicates, so the following does not work
# eye_contour[cbind(ts$y, ts$x)]=ts$Time

# filled.contour(x=1:ncol(prob2), y=1:nrow(prob2),
# 		t(log(eye_contour+0.01)),
# 		xlim=xbounds, ylim=ybounds)



