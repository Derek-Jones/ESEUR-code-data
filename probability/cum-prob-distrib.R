#
# cum-prob-distrib.R,  6 Aug 16
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(4, 1)

par(mar=c(1.2, 2.0, 1, 0.8))
brew_col=rainbow(3)

plot(c(0, 1,1, 2,2, 3,3, 4,4, 5), c(0, 0, 0.25,0.25, 0.5,0.5, 0.75,0.75, 1, 1), type="l",
	col=brew_col[1],
	xlab="", ylab="")

x_geom=0:10
plot(x_geom, pgeom(x_geom, prob=0.2),
	col=brew_col[1],
	xlim=range(x_geom), ylim=c(0, 1),
	xlab="", ylab="")
points(x_geom, pgeom(x_geom, prob=0.4), col=brew_col[2])
points(x_geom, pgeom(x_geom, prob=0.6), col=brew_col[3])
legend(x="bottomright", legend=c("prob=0.2", "prob=0.4", "prob=0.6"), bty="n", fill=brew_col, cex=1.1)

x_binom=0:10
plot(x_binom, pbinom(x_binom, size=10, prob=0.2),
	col=brew_col[1],
	xlim=range(x_binom), ylim=c(0, 1),
	xlab="", ylab="")
points(x_binom, pbinom(x_binom, size=10, prob=0.4), col=brew_col[2])
points(x_binom, pbinom(x_binom, size=25, prob=0.2), col=brew_col[3])
legend(x="bottomright", legend=c("size=10\nprob=0.2\n", "size=10\nprob=0.4\n", "size=25\nprob=0.2"), bty="n", fill=brew_col, cex=1.1)

lambda_str=function(num) as.expression(substitute(lambda == num))

x_pois=0:10
plot(x_pois, ppois(x_pois, lambda=2),
	col=brew_col[1],
	xlim=range(x_pois), ylim=c(0, 1),
	xlab="", ylab="")
points(x_pois, ppois(x_pois, lambda=4), col=brew_col[2])
points(x_pois, ppois(x_pois, lambda=7), col=brew_col[3])
legend(x="bottomright", legend=c(lambda_str(2), lambda_str(4), lambda_str(7)),
		 bty="n", fill=brew_col, cex=1.1)

