#
# like-n-dis.R, 23 Apr 18
# Data from:
# The Sources and Consequences of the Fluent Processing of numbers
# Dan King and Chris Janiszewski
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(2, 1)


lnd=read.csv(paste0(ESEUR_dir, "developers/like-n-dis.csv.xz"), as.is=TRUE)

plot(lnd$Number, lnd$Like, type="l", col=point_col,
	xaxs="i",
	xlab="Number", ylab="Like\n")
lines(loess.smooth(lnd$Number, lnd$Like, span=0.3), col=loess_col)


spectrum(lnd$Like, main="Spectrum density", sub="", col=point_col,
		xlab="Frequency", ylab="Density\n")

# spectrum(lnd$Dislike)

# spectrum(lnd$Neutral)

