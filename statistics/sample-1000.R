#
# sample-1000.R,  8 Jan 16
#
# Data from:
#
# Statistical Performance Comparisons of Computers
# Tianshi Chen and Yunji Chen and Qi Guo and Olivier Temam and Tue Wu and Weiwu Hu
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

pal_col=rainbow(3)

bench_pop=read.csv(paste0(ESEUR_dir, "statistics/office_rsynth.gcc.basetime.csv.xz"))

clock_den=density(bench_pop$clocks)
max_y=max(clock_den$y)

plot(clock_den, main="",
	ylim=range(clock_den$y)*1.02, # a hack so that 'median' is not cropped
	xlab="Execution time", ylab="Density\n")

m_1=mean(bench_pop$clocks)
m_2=median(bench_pop$clocks)
# Point of maximum density
m_3=clock_den$x[which(clock_den$y == max(clock_den$y))]

lines(c(m_1, m_1), c(0, max_y), col=pal_col[1])
lines(c(m_2, m_2), c(0, max_y), col=pal_col[2])
lines(c(m_3, m_3), c(0, max_y), col=pal_col[3])

text(m_1, max_y, "mean", pos=4, col=pal_col[1], offset=c(0.2, -0.2), cex=1.2)
text(m_2, max_y, "median", pos=3, col=pal_col[2], cex=1.2)
text(m_3, max_y, "mode", pos=2, col=pal_col[3], offset=c(0.2, -0.2), cex=1.2)

