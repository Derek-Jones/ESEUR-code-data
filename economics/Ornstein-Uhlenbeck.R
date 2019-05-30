#
# Ornstein-Uhlenbeck.R, 26 Mar 19
# Data from:
# Example
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example  Ornstein-Uhlenbeck stochastic

source("ESEUR_config.r")


library("Sim.DiffProc")

pal_col=rainbow(3)

set.seed(1)

e_mu=1
e_sigma=0.1
e_theta=1

# Values chosen to create an 'interesting' looking plot
maint=HWV(N=1000, M=10, x0=0, t0=0, T=5, theta=e_theta, mu=e_mu, sigma=e_sigma)

plot(maint, plot.type="single", col=pal_col[2],
	yaxs="i",
	xlab="Time", ylab="Maintenance\n")

xbounds=seq(0, 5, by=0.1)

# The following ignores the time dependency.
e_sd=sqrt(e_sigma^2/(2*e_theta))

# lines(as.vector(time(maint)), rowMeans(maint), col=pal_col[1])

# x0e^{-theta*time}+mu*(1-e^{-theta*time})
lines(xbounds, e_mu*(1-exp(-e_theta*xbounds)), col=pal_col[1])

lines(xbounds, e_mu*(1-exp(-e_theta*xbounds))*(1+e_sd), col=pal_col[3])
lines(xbounds, e_mu*(1-exp(-e_theta*xbounds))*(1-e_sd), col=pal_col[3])

