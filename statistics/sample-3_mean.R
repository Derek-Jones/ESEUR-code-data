#
# sample-3_mean.R,  8 Sep 15
#
# Data from:
#
# Statistical Performance Comparisons of Computers
# Tianshi Chen and Yunji Chen and Qi Guo and Olivier Temam and Tue Wu and Weiwu Hu
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG benchmark performance hardware

source("ESEUR_config.r")


bench_pop=read.csv(paste0(ESEUR_dir, "statistics/office_rsynth.gcc.basetime.csv.xz"))

NUM_SAMPLES=100


sample_mean=function(sample_size)
{
a_sample=sample(bench_pop$clocks, size=sample_size)

return(c(mean(a_sample), sd(a_sample)))
}


plot_sample=function(sample_vec)
{
plot(1, log="y", xaxt="n", bty="n",
	ylab="Cycles\n", xlab="",
	xlim=c(1, ncol(size_3)), ylim=c(min(sample_vec[1,])/10,
					max(sample_vec[1,])*2))

dummy=sapply(1:NUM_SAMPLES,
		function(X)
		{
		lines(c(X, X), c(sample_vec[1, X]-sample_vec[2, X],
                                 sample_vec[1, X]+sample_vec[2, X]),
			col=point_col)
		points(X, sample_vec[1, X], col="red")
		})

pop_mean=mean(bench_pop$clocks)
pop_sd=sd(bench_pop$clocks)

lines(c(1, NUM_SAMPLES), c(pop_mean, pop_mean), col="blue")
lines(c(1, NUM_SAMPLES), c(pop_mean-pop_sd, pop_mean-pop_sd), col="green")
lines(c(1, NUM_SAMPLES), c(pop_mean+pop_sd, pop_mean+pop_sd), col="green")
}

size_3=replicate(NUM_SAMPLES, sample_mean(3))
plot_sample(size_3)

