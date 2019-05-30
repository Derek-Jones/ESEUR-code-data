#
# drift-variance.R, 18 Mar 19
# Data from:
# Example
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example diffusion drift Wiener-process


source("ESEUR_config.r")


pal_col=rainbow(3)

# All values picked to make the plot look good

set.seed(11)


brownian=function(n=length(xbounds))
{
inc=0.13
return(c(0, cumsum(inc*rnorm(n-1))))
}


plot(-1, type="n",
	xaxt="n", yaxt="n",
	xlim=c(0, 10), ylim=c(0, 10),
	xlab="Time", ylab="X")

xbounds=seq(0, 10, by=0.1)

lines(xbounds, 0.7*xbounds+xbounds^0.5, col=pal_col[1])
lines(xbounds, 0.7*xbounds-xbounds^0.5, col=pal_col[1])
d=replicate(15, lines(xbounds, 0.7*xbounds+brownian(), col=pal_col[2]))

lines(c(0, 10), c(0, 7), col="grey")

lines(c(5, 5), c(0.7*5-5^0.5, 0.7*5+5^0.5), col=pal_col[3])

