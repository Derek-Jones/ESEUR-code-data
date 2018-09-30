#
# boot-power.R,  9 Sep 18
# Data from:
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example statistical-power


source("ESEUR_config.r")


a_test_stat=function(sample_1, sample_2, alpha)
{
# Really ought to use the bootstrap here, but it takes forever.
# Cheat and use the 'manual' test, which is known to work for this case,
# so things run a bit faster.
t=t.test(sample_1, sample_2)
return(t$p.value)
}


boot_power=function(pop_1, pop_2, sample_size, test_stat,
		    alpha=0.05)
{
num_samples=5000 # Number of times to run the 'experiment'
results = sapply(1:num_samples, function(X)
	{
	sample_1 = sample(pop_1, size=sample_size, replace=TRUE) 
        sample_2 = sample(pop_2, size=sample_size, replace=TRUE) 
        test = test_stat(sample_1, sample_2, alpha)
	})

return(sum(results<alpha)/num_samples)
}


sample_size_pow=function(mean_diff)
{
# Generate data that represents the two populations
pop_size=10000
population_1=rnorm(pop_size, mean=0, sd=1)
population_2=rnorm(pop_size, mean=0+mean_diff, sd=1)

pow_res=sapply(possible_sample_sizes, function(X)
		boot_power(population_1, population_2, X, a_test_stat))
}

mean_diff_pow=function()
{
pow_res=sapply(possible_mean_diffs, function(X) sample_size_pow(X))
}



possible_mean_diffs=seq(0.1, 0.9, by=0.2)
possible_sample_sizes=seq(5, 100, by=5)

t_pow=mean_diff_pow()

pal_col=rainbow(ncol(t_pow))

plot(0, type="n",
	yaxs="i",
	xlim=range(possible_sample_sizes), ylim=c(0, 1),
	xlab="Sample size", ylab="Power")

dummy=sapply(1:length(possible_mean_diffs), function(X)
		{
		lines(possible_sample_sizes, t_pow[ , X], col=pal_col[X])
		text(40, t_pow[8, X], possible_mean_diffs[X], pos=1)
		})

