#
# two-norm.R,  6 Aug 16
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

plot_layout(3, 2)

# Expand to fill space normally occupied by the axis
par(mar=c(0.7, 0.5, 0.7, 0.5))
x_bounds=seq(-4, 4, 0.25)

plot(cut(rnorm(100), breaks=x_bounds), xaxt="n", yaxt="n",
	xlab="", col="yellow")
plot(cut(rnorm(100), breaks=x_bounds), xaxt="n", yaxt="n",
	xlab="", col="yellow")
plot(cut(rnorm(100), breaks=x_bounds), xaxt="n", yaxt="n",
	xlab="100 data points", col="yellow")

plot(cut(rnorm(1000), breaks=x_bounds), xaxt="n", yaxt="n",
	xlab="", col="yellow")
plot(cut(rnorm(1000), breaks=x_bounds), xaxt="n", yaxt="n",
	xlab="", col="yellow")
plot(cut(rnorm(1000), breaks=x_bounds), xaxt="n", yaxt="n",
	xlab="1000 data points", col="yellow")

