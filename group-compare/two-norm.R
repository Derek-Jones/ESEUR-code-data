#
# two-norm.R,  9 Jan 16
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

plot_layout(2, 3)


x_bounds=seq(-4, 4, 0.25)

plot(cut(rnorm(100), breaks=x_bounds), xaxt="n", yaxt="n",
	xlab="", col="yellow")
plot(cut(rnorm(1000), breaks=x_bounds), xaxt="n", yaxt="n",
	xlab="", col="yellow")

plot(cut(rnorm(100), breaks=x_bounds), xaxt="n", yaxt="n",
	xlab="100 data points", col="yellow")
plot(cut(rnorm(1000), breaks=x_bounds), xaxt="n", yaxt="n",
	xlab="1000 data points", col="yellow")

plot(cut(rnorm(100), breaks=x_bounds), xaxt="n", yaxt="n",
	xlab="", col="yellow")
plot(cut(rnorm(1000), breaks=x_bounds), xaxt="n", yaxt="n",
	xlab="", col="yellow")

