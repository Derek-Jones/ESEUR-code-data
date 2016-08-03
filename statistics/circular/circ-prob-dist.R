#
# circ-prob-dist.R,  3 Jan 16
#
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("circular")

pal_col=rainbow(3)

plot_layout(3, 1)

mu = circular(pi/2)
theta = circular(seq(0, 2*pi, by=pi/360))

curve.circular(dcarthwrite(x, mu, 1), join=TRUE, shrink=1.1, col=pal_col[1])
y = dwrappedcauchy(theta, mu, 0.25)
lines(theta, y, col=pal_col[2])
y = dvonmises(theta, mu, 0.52)
lines(theta, y, col=pal_col[3])

curve.circular(dcarthwrite(x, mu, 10), join=TRUE, shrink=1.1, col=pal_col[1])
y = dwrappedcauchy(theta, mu, 0.5)
lines(theta, y, col=pal_col[2])
y = dvonmises(theta, mu, 1.16)
lines(theta, y, col=pal_col[3])

curve.circular(dcarthwrite(x, mu, 0.1), join=TRUE, shrink=1.3, col=pal_col[1])
y = dwrappedcauchy(theta, mu, 0.75)
lines(theta, y, col=pal_col[2])
y = dvonmises(theta, mu, 2.37)
lines(theta, y, col=pal_col[3])



# curve.circular(djonespewsey(x, mu, 2, -3/2), join=TRUE, shrink=2.0, col=pal_col[1])
# y=djonespewsey(theta, mu, 1, 0.0000001)
# lines(theta, y, col=pal_col[2])


