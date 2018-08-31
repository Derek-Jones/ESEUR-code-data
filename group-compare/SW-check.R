#
# SW-check.R,  6 Jan 16
#
# Data from:
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example


source("ESEUR_config.r")


pal_col=rainbow(4)

num_replications=1000

SW_func=function(n, e_distr)
{
rr=e_distr(n)

return(shapiro.test(rr)$p.value)
}


SW_rep=function(n, e_distr)
{
c_exp=replicate(num_replications, SW_func(n, e_distr))

return(length(which(c_exp < 0.05)))
}


c_exp=sapply(3:50, function(X) SW_rep(X, rexp))
plot(c_exp/num_replications, col=pal_col[1],
	xlab="Items in dataset", ylab="Correct decision probability\n",
	ylim=c(0, 1))

c_unif=sapply(3:50, function(X) SW_rep(X, runif))
points(c_unif/num_replications, col=pal_col[2])

c_lnorm=sapply(3:50, function(X) SW_rep(X, rlnorm))
points(c_lnorm/num_replications, col=pal_col[3])

c_norm=sapply(3:50, function(X) SW_rep(X, rnorm))
points(c_norm/num_replications, col=pal_col[4])


legend(x="topleft", legend=c("exponential", "uniform", "log normal", "normal"),
			bty="n", fill=pal_col, cex=1.2)

