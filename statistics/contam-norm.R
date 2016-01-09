#
# contam-norm.R, 16 Dec 15
#
# R code for book "Empirical Software Engineering using R"
# Derek M. Jones, http://shape-of-code.coding-guidelines.com
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)

contam_sd=5


rcontaminated=function(n, mean=0, sd=1)
{
eta=0.1
# result_sd = sqrt((1-eta)*sd^2+eta*contam_sd^2) -> sqrt(1-0.1+0.1*10^2) -> 3.3
t1=rnorm((1-eta)*n, mean, sd)
t2=rnorm(eta*n, mean, sd*contam_sd)
return(c(t1, t2))
}


contam_vals=rcontaminated(10000)
normal_vals=rnorm(10000)

plot(density(contam_vals), col=pal_col[1],
	main="",
	xlab="", ylab="",
	xlim=c(-4, 4), ylim=c(0, 0.45))
q=quantile(contam_vals, c(0.025, 0.975))
lines(c(q[1], q[1]), c(0, 0.1), col=pal_col[1])
lines(c(q[2], q[2]), c(0, 0.1), col=pal_col[1])
lines(density(normal_vals), col=pal_col[2])
q=quantile(normal_vals, c(0.025, 0.975))
lines(c(q[1], q[1]), c(0, 0.1), col=pal_col[2])
lines(c(q[2], q[2]), c(0, 0.1), col=pal_col[2])

#
# How good a job does the Shapiro-Wilk test do in detecting that the
# Contaminated Normal distribution is not Normally distributed?
is_normal=function(norm_func, samp_size)
{
cx=norm_func(samp_size)
t=shapiro.test(cx)
return (t$p.value > 0.05)
}
 
how_norm=function(samp_size)
{
q=sapply(1:10000, function(x) is_normal(rcontaminated, samp_size))
n1=length(which(q))

q=sapply(1:10000, function(x) is_normal(rnorm, samp_size))
n2=length(which(q))

return(c(n1, n2))
}


how_norm(10)
how_norm(20)

