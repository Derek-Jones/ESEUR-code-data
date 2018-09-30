#
# sample-3_12_mean.R, 29 Sep 18
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


pal_col=rainbow(2)


bench_pop=read.csv(paste0(ESEUR_dir, "statistics/office_rsynth.gcc.basetime.csv.xz"))

NUM_SAMPLES=1000


sample_mean=function(sample_size)
{
a_sample=sample(bench_pop$clocks, size=sample_size)

return(c(mean(a_sample), sd(a_sample)))
}


size_3=replicate(NUM_SAMPLES, sample_mean(3))
size_12=replicate(NUM_SAMPLES, sample_mean(12))


m_3=density(size_3[1,])
xbounds=range(m_3$x)
m_12=density(size_12[1,])
ybounds=range(m_12$y)

plot(m_3, col=pal_col[1], main="",
	xaxs="i", yaxs="i",
	xlim=xbounds, ylim=ybounds,
	xlab="", ylab="Density\n")
lines(m_12, col=pal_col[2])

legend(x="topright", legend=c("3 items", "12 items"),
		bty="n", fill=pal_col, cex=1.2)

