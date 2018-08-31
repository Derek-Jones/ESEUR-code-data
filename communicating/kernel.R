#
# kernel.R,  2 Dec 15
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones

source("ESEUR_config.r")


brew_col=rainbow(3)

vals=c(rep(0, 5), 1, rep(0, 5))

plot(density(vals, kernel="gaussian", from=-0.5, to=0.5),
	main="", col=brew_col[1],
	xlim=c(-0.5, 0.5), ylim=c(0, 2.2),
	xlab="")
lines(density(vals, kernel="triangular", from=-0.5, to=0.5),
	col=brew_col[2])
lines(density(vals, kernel="rectangular", from=-0.5, to=0.5),
	col=brew_col[3])

