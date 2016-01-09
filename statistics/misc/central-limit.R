#
# central-limit.R,  4 Sep 12
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


sample.mean=function(mean.list, dot.col)
{
x.vals=seq(0.3, 0.7, 0.005)
t=table(cut(mean.list, x.vals))
plot(x=x.vals[-1], y=as.integer(t), col=dot.col,
        xlab="Mean", ylab="Occurrences",
        xlim=c(0.3, 0.7), ylim=c(0, 2200))
}



# Sample sizes of 10, 100 and 1000
sample.unif=replicate(10000, mean(runif(1000, 0, 1)))
sample.mean(sample.unif, "blue")
sample.unif=replicate(10000, mean(runif(100, 0, 1)))
par(new=TRUE)
sample.mean(sample.unif, "green")
sample.unif=replicate(10000, mean(runif(10, 0, 1)))
par(new=TRUE)
sample.mean(sample.unif, "black")
lines(c(0.5, 0.5), c(0.0, 5000), col="red")

# sample.unif=replicate(10000, mean(runif(1000, 0, 1)))
# hist(sample.unif, breaks=50, freq=FALSE, col="blue",
#         xlab="Mean",
#         xlim=c(0.3, 0.7), ylim=c(0, 55))
# sample.unif=replicate(10000, mean(runif(100, 0, 1)))
# par(new=TRUE)
# hist(sample.unif, breaks=50, freq=FALSE, col="green",
#         xlab="",
#         xlim=c(0.3, 0.7), ylim=c(0, 55))
# sample.unif=replicate(10000, mean(runif(10, 0, 1)))
# par(new=TRUE)
# hist(sample.unif, breaks=50, freq=FALSE, col="black",
#         xlab="",
#         xlim=c(0.3, 0.7), ylim=c(0, 55))
# lines(c(0.5, 0.5), c(0.0, 5000), col="red")


# sample.unif.sqrt=replicate(10000, sqrt(mean(runif(1000, 0, 1))))
# hist(sample.unif.sqrt, breaks=50)
# 
# sample.pois=replicate(10000, mean(rpois(1000, 0.5)))
# hist(sample.pois, breaks=50)
# 
# sample.exp=replicate(10000, mean(rexp(1000, 0.5)))
# hist(sample.exp, breaks=50)
# 

norm.conf.int=function(some.values, conf=95)
{
alpha=(100-conf)/100
x.mean=mean(some.values)
x.len=length(some.values)
# qt is Student's t-distribution with n-1 degrees of freedom,
# sqrt(var(some.values)/x.len) calculates the Standard error.
# If n is large we could save some computing time by using qnorm
x.conf.int=qt(1-alpha/2, df=x.len-1) * sqrt(var(some.values)/x.len)

# return the lower and upper bounds of the confidence interval for the mean.
return(c(x.mean-x.conf.int, x.mean+x.conf.int))
}


unif.conf.int=function(some.values, conf=95)
{
alpha=(100-conf)/100
x.len=length(some.values)
x.min=min(some.values)
x.max=max(some.values)
#
# For large x.len this can be approximated by:
# eta=log(alpha)/x.len
eta=exp(-log(alpha)/(x.len-1))-1
x.ci=(x.max-x.min)*alpha/2
x.mean=(x.max+x.min)/2

return(c(x.mean-x.ci, x.mean+x.ci))
}


pois.conf.int=function(some.values, conf=95)
{
alpha=(100-conf)/100

x.mean=mean(some.values)

# Doe snot make use of the number of observations
return(c(x.mean-qchisq(alpha/2, 2*x.mean)/2, x.mean+qchisq(1-alpha/2, 2*(x.mean+1))/2))
}


test.max=30

plot(c(0.5, 0.5), c(0, 3*test.max), xlim=c(0.35, 0.65), ylim=c(1, 3*test.max),
     type="l", col="black",
     xlab="Mean value", ylab="")

num_tests=1:test.max

par(col="green")
dummy=sapply(0+num_tests, function(x) lines(norm.conf.int(runif(100, 0, 1)), c(x, x)))

par(col="red")
dummy=sapply(test.max+num_tests, function(x) lines(unif.conf.int(runif(100, 0, 1)), c(x, x)))

par(col="blue")
dummy=sapply(81:120, function(x) lines(wilcox.test(runif(100, 0, 1), conf.int=TRUE)$conf.int, c(x, x)))

