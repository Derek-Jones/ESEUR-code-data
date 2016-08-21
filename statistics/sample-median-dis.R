#
# sample-median-dis.R, 20 Aug 16
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(2, 1)

NUM_REPLICATE=1000

discrete_sample=function(sample_size)
{
#return(sample(1:10, sample_size, replace=TRUE, dnorm(1:10, mean=5, sd=2)))
return(sample(0:9, sample_size, replace=TRUE, dbinom(0:9, size=10, prob=6.5/10)))
}


samp_mean=replicate(NUM_REPLICATE, mean(discrete_sample(30)))
samp_median=replicate(NUM_REPLICATE, median(discrete_sample(30)))

plot(table(samp_median), yaxt="n", col=point_col,
	xlab="Median", ylab="Occurrences")

# Explicitly draw x-axis to cure spurious choice of axis values.
plot(table(samp_mean), yaxt="n", col=point_col,
	xaxt="n",
	xlab="Mean", ylab="Occurrences")
axis(1, at=c(5.5, 6, 6.5, 7))

