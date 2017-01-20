#
# rabbit.R, 11 Dec 16
# Equations from:
# Grapher Pics
# Jerome A. White
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


x=seq(-4.7, 4.7, by=0.002)

# plot(0, type="n",
# 	xlim=c(-4.7, 4.7), ylim=c(-1.7, 4.5),
#	xlab="", ylab="")
# 
# dummy=sapply(x, function(X) points(rep(X, 12), 
# 		c(0,0,0,0,1,1,1,1,-1,-1,-1,-1)*sqrt(3)*X +c(4.4,0,-0.8,-1.6,-6.8,2,3.6,5.2,-6.8,2,3.6,5.2)/
# 		as.numeric(abs(5*sqrt(3)*X +c(0,4,8,0,-28,3,7,17,28,-7,-15,-17)) <= c(4,14,22,26,2.4,7,11,13,2.3,7,11,13)), pch="."))
# 
# 

plot(0, type="n", col=point_col,
	xlim=c(-4.0, 4.0), ylim=c(-3.2, 3.1),
	xlab="", ylab="")

# y1 = c(1,-.7,.5)*sqrt(c(1.3, 2,.3)^2 - x^2) - c(.6,1.5,1.75)  # 3
# y2 =0.6*sqrt(4 - x^2)-1.5/as.numeric(1.3 <= abs(x))           # 1
# y3 = c(1,-1,1,-1,-1)*sqrt(c(.4,.4,.1,.1,.8)^2 -(abs(x)-c(.5,.5,.4,.4,.3))^2) - c(.6,.6,.6,.6,1.5) # 5
# y4 =(c(.5,.5,1,.75)*tan(pi/c(4, 5, 4, 5)*(abs(x)-c(1.2,3,1.2,3)))+c(-.1,3.05, 0, 2.6))/
# 	as.numeric(c(1.2,.8,1.2,1) <= abs(x) & abs(x) <= c(3,3, 2.7, 2.7))                 # 4
# y5 =(1.5*sqrt(x^2 +.04) + x^2 - 2.4) / as.numeric(abs(x) <= .3)                            # 1
# y6 = (2*abs(abs(x)-.1) + 2*abs(abs(x)-.3)-3.1)/as.numeric(abs(x) <= .4)                    # 1
# y7 =(-.3*(abs(x)-c(1.6,1,.4))^2 -c(1.6,1.9, 2.1))/
# 	as.numeric(c(.9,.7,.6) <= abs(x) & abs(x) <= c(2.6, 2.3, 2))                       # 3

dummy=sapply(x, function(X) points(rep(X, 18), c(
	c(1, -0.7, 0.5)*sqrt(c(1.3, 2, 0.3)^2-X^2) - c(0.6, 1.5 ,1.75),
	0.6*sqrt(4 - X^2)-1.5/as.numeric(1.3 <= abs(X)),
	c(1, -1, 1, -1, -1)*sqrt(c(0.4, 0.4, 0.1, 0.1, 0.8)^2-(abs(X)-c(0.5, 0.5, 0.4, 0.4, 0.3))^2) - c(0.6, 0.6, 0.6, 0.6, 1.5),
	(c(0.5, 0.5, 1, 0.75)*tan(pi/c(4, 5, 4, 5)*(abs(X)-c(1.2, 3, 1.2, 3)))+c(-0.1, 3.05, 0, 2.6))/
		as.numeric(c(1.2, 0.8, 1.2, 1) <= abs(X) & abs(X) <= c(3,3, 2.7, 2.7)),
	(1.5*sqrt(X^2+0.04) + X^2 - 2.4) / as.numeric(abs(X) <= 0.3),
	(2*abs(abs(X)-0.1)+2*abs(abs(X)-0.3)-3.1)/as.numeric(abs(X) <= 0.4),
	(-0.3*(abs(X)-c(1.6, 1, 0.4))^2-c(1.6, 1.9, 2.1))/
		as.numeric(c(0.9, 0.7, 0.6) <= abs(X) & abs(X) <= c(2.6, 2.3, 2))
						),
					pch="."
					))

# 
# library("plyr")
# 
# rab_points=adply(x, 1, function(X) data.frame(x=rep(X, 18), y=c(
# 	c(1, -0.7, 0.5)*sqrt(c(1.3, 2, 0.3)^2-X^2) - c(0.6, 1.5 ,1.75),
# 	0.6*sqrt(4 - X^2)-1.5/as.numeric(1.3 <= abs(X)),
# 	c(1, -1, 1, -1, -1)*sqrt(c(0.4, 0.4, 0.1, 0.1, 0.8)^2-(abs(X)-c(0.5, 0.5, 0.4, 0.4, 0.3))^2) - c(0.6, 0.6, 0.6, 0.6, 1.5),
# 	(c(0.5, 0.5, 1, 0.75)*tan(pi/c(4, 5, 4, 5)*(abs(X)-c(1.2, 3, 1.2, 3)))+c(-0.1, 3.05, 0, 2.6))/
# 		as.numeric(c(1.2, 0.8, 1.2, 1) <= abs(X) & abs(X) <= c(3,3, 2.7, 2.7)),
# 	(1.5*sqrt(X^2+0.04) + X^2 - 2.4) / as.numeric(abs(X) <= 0.3),
# 	(2*abs(abs(X)-0.1)+2*abs(abs(X)-0.3)-3.1)/as.numeric(abs(X) <= 0.4),
# 	(-0.3*(abs(X)-c(1.6, 1, 0.4))^2-c(1.6, 1.9, 2.1))/
# 		as.numeric(c(0.9, 0.7, 0.6) <= abs(X) & abs(X) <= c(2.6, 2.3, 2))
# 						)))
# 
# 
# rab_points$X1=NULL
# rb=subset(rab_points, (!is.na(x)) & (!is.na(y) & is.finite(y)))
# 
# x=sample.int(nrow(rb), 300)
# plot(rb$x[x], rb$y[x],
# 	bty="n", xaxt="n", yaxt="n", pch=4, cex=0.5,
# 	xlab="", ylab="")
# 
# rm_nearest=function(jp)
# {
# keep=((dot_im$x[(jp+1):(jp+window_size)]-dot_im$x[jp])^2+
#       (dot_im$y[(jp+1):(jp+window_size)]-dot_im$y[jp])^2) < min_dist
# keep=c(keep, TRUE) # make sure which has something to return
# return(jp+which(keep))
# }
# 
# 
# window_size=500
# max_jp=nrow(rb)
# cur_jp=1
# dot_im=rb
# 
# while (cur_jp <= nrow(dot_im))
#    {
# #   min_dist=0.05+0.50*runif(window_size)
#    min_dist=0.05+0.30*runif(1)
#    dot_im=dot_im[-rm_nearest(cur_jp), ]
#    cur_jp=cur_jp+1
#    }
# 
# plot(dot_im$x, dot_im$y,
# 	bty="n", xaxt="n", yaxt="n", pch=4, cex=0.5,
# 	xlab="", ylab="")
# 
# 
