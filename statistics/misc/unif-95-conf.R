#
# unif-95-conf.R,  7 Sep 12
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


mean.conf.int=function(some.values, alpha.frac=0.95)
{
# default alpha.frac is for 95% confidence bound
x.mean=mean(some.values)
x.len=length(some.values)
# qt is Student's t-distribution with n-1 degrees of freedom,
# sqrt(var(some.values)/x.len) calculates the Standard error.
# If n is large we could save some computing time by using qnorm
x.conf.int=qt(alpha.frac+(1-alpha.frac)/2, df=x.len-1) * sqrt(var(some.values)/x.len)

# return the lower and upper bounds of the confidence interval for the mean.
return(c(x.mean-x.conf.int, x.mean+x.conf.int))
}


# Confidence intervals for a selection of mean values

plot(c(0.5, 0.5), c(0, 40), xlim=c(0.35, 0.65), ylim=c(1, 40),
     type="l", col="red",
     xlab="Mean value", ylab="")
dummy=sapply(1:40, function(x) lines(mean.conf.int(runif(100, 0, 1)), c(x, x)))

