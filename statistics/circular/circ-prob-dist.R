#
# circ-prob-dist.R, 14 Oct 18
# Data from:
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example circular


source("ESEUR_config.r")


library("circular")

pal_col=rainbow(3)

plot_layout(2, 2, max_height=12.0)
par(mar=c(0.5, 0.0, 0.5, 0.0))
# par(oma=c(0.5, 0.0, 0.5, 0.0))

mu = circular(pi/2)
theta = circular(seq(0, 2*pi, by=pi/360))

curve.circular(dcarthwrite(x, mu, 1), join=TRUE, cex=1.5, tcl.text=0.3,
						 shrink=1.5, col=pal_col[1])
y = dwrappedcauchy(theta, mu, 0.25)
lines(theta, y, col=pal_col[2])
y = dvonmises(theta, mu, 0.52)
lines(theta, y, col=pal_col[3])

curve.circular(dcarthwrite(x, mu, 10), join=TRUE, cex=1.5, tcl.text=0.3,
						 shrink=1.5, col=pal_col[1])
y = dwrappedcauchy(theta, mu, 0.5)
lines(theta, y, col=pal_col[2])
y = dvonmises(theta, mu, 1.16)
lines(theta, y, col=pal_col[3])

# Changing ylim from c(-1, 1) brings the plots closer together
curve.circular(dcarthwrite(x, mu, 0.1), join=TRUE, cex=1.5, tcl.text=0.4,
					 shrink=1.7, col=pal_col[1], ylim=c(-0.5, 1.2))
y = dwrappedcauchy(theta, mu, 0.75)
lines(theta, y, col=pal_col[2])
y = dvonmises(theta, mu, 2.37)
lines(theta, y, col=pal_col[3])



# curve.circular(djonespewsey(x, mu, 2, -3/2), join=TRUE, shrink=2.0, col=pal_col[1])
# y=djonespewsey(theta, mu, 1, 0.0000001)
# lines(theta, y, col=pal_col[2])


