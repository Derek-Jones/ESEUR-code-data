#
# ad-check.R, 10 Jun 14
#
# Measure accuracy of Anderson-Darling test
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

# Needed for ad.test
library("kSamples")


num_replications=1000

exp_norm_ks=function(n)
{
rr=rexp(n)
rn=rnorm(n, mean=mean(rr), sd=sd(rr))

return(ks.test(rr, rn)$p.value)
}


c_100=replicate(num_replications, exp_norm_ks(100))
length(which(c_100 < 0.05))

# 95% detection of difference in distributions
c_200=replicate(num_replications, exp_norm_ks(200))
length(which(c_200 < 0.05))


# n=75
# rr=rexp(n)
# rn=rnorm(n, mean=mean(rr), sd=sd(rr))
# plot(ecdf(rr),
#         xlim=c(-0.2, 1), ylim=c(0, 1))
# par(new=TRUE)
# plot(ecdf(rn), col="red",
#         xlim=c(-0.2, 1), ylim=c(0, 1))


unif_norm_ks=function(n)
{
rr=runif(n)
rn=rnorm(n, mean=mean(rr), sd=sd(rr))

return(ks.test(rr, rn)$p.value)
}


c_550=replicate(num_replications, unif_norm_ks(550))
length(which(c_550 < 0.05))

# 95% detection of difference in distributions
c_1100=replicate(num_replications, unif_norm_ks(1100))
length(which(c_1100 < 0.05))


exp_norm_ad=function(n)
{
rr=rexp(n)
rn=rnorm(n, mean=mean(rr), sd=sd(rr))

return(ad.test(rr, rn)$ad[1, 3])
}


c_100=replicate(num_replications, exp_norm_ad(100))
length(which(c_100 < 0.05))

# 95% detection of difference in distributions
c_150=replicate(num_replications, exp_norm_ad(150))
length(which(c_150 < 0.05))


unif_norm_ad=function(n)
{
rr=runif(n)
rn=rnorm(n, mean=mean(rr), sd=sd(rr))

return(ad.test(rr, rn)$ad[1, 3])
}


# 95% detection of difference in distributions
c_550=replicate(num_replications, unif_norm_ad(550))
length(which(c_550 < 0.05))


