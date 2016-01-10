#
# data-plot.R,  9 Jan 16
#
# Modified version of...
#
#Title: An example of the correlation of x and y for various distributions of (x,y) pairs
#Tags: Mathematics; Statistics; Correlation
#Author: Denis Boigelot
#Packets needed : mvtnorm (rmvnorm), RSVGTipsDevice (devSVGTips)
#How to use: output()
#
#This is a translated version in R of Matematica 6 code by Imagecreator.
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library(mvtnorm)

plot_layout(2, 4)

par(oma = c(0,0,0,0), mar=c(2,2,2,0))


MyPlot <- function(xy, xlim = c(-4, 4), ylim = c(-4, 4), eps = 1e-15) {
#   title = round(cor(xy[,1], xy[,2]), 1)
#   if (sd(xy[,2]) < eps) title = "" # corr. coeff. is undefined
   plot(xy, col="blue",
	xlab = "", ylab = "",
        pch = 16, cex = 0.2,
        xaxt = "n", yaxt = "n", bty = "n",
        xlim = xlim, ylim = ylim)
}

curvy_line = function(x, y)
{
plot(x, y, col="blue",
	xlab = "", ylab = "",
        pch = 16, cex = 0.2,
        xaxt = "n", yaxt = "n", bty = "n")
}

rotation <- function(t, X) return(X %*% matrix(c(cos(t), sin(t), -sin(t), cos(t)), ncol = 2))

Others <- function(n = 5000)
{
   x = runif(n, -1, 1)
   y = 4 * (x^2 - 1/2)^2 + runif(n, -1, 1)/3
   MyPlot(cbind(x,y), xlim = c(-1, 1), ylim = c(-1/3, 1+1/3))

   y = runif(n, -1, 1)
   xy = rotation(-pi/8, cbind(x,y))
   lim = sqrt(2+sqrt(2)) / sqrt(2)
#   MyPlot(xy, xlim = c(-lim, lim), ylim = c(-lim, lim))

   xy = rotation(-pi/8, xy)
   MyPlot(xy, xlim = c(-sqrt(2), sqrt(2)), ylim = c(-sqrt(2), sqrt(2)))
   
#   y = 2*x^2 + runif(n, -1, 1)
#   MyPlot(cbind(x,y), xlim = c(-1, 1), ylim = c(-1, 3))

#   y = (x^2 + runif(n, 0, 1/2)) * sample(seq(-1, 1, 2), n, replace = TRUE)
#   MyPlot(cbind(x,y), xlim = c(-1.5, 1.5), ylim = c(-1.5, 1.5))

   y = cos(x*pi) + rnorm(n, 0, 1/8)
   x = sin(x*pi) + rnorm(n, 0, 1/8)
   MyPlot(cbind(x,y), xlim = c(-1.5, 1.5), ylim = c(-1.5, 1.5))

   xy1 = rmvnorm(n/4, c( 3,  3))
   xy2 = rmvnorm(n/4, c(-3,  3))
   xy3 = rmvnorm(n/4, c(-3, -3))
   xy4 = rmvnorm(n/4, c( 3, -3))
   MyPlot(rbind(xy1, xy2, xy3, xy4), xlim = c(-3-4, 3+4), ylim = c(-3-4, 3+4))
}

output = function()
{
x=seq(1, 10, by=0.005)

y=x+rnorm(length(x), sd=0.1)
curvy_line(x, y)

y=x+rnorm(length(x), sd=0.7)
curvy_line(x, y)

y=x^2-0.5*x+rnorm(length(x), mean=3, sd=x/2)
curvy_line(x, y)

y=x^3-8*x^2-0.5*x+rnorm(length(x), mean=3, sd=x/2)
curvy_line(x, y)

Others()
}

output()

