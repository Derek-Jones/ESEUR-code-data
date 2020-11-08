#
# thecostofsorting.R, 19 Oct 20
#
# Data from:
# Energy-Efficient Data Processing at Sweet Spot Frequencies
# Sebastian G{\"o}tz and Thomas Ilsche and Jorge Cardoso and Josef Spillner and Uwe A{\ss}mann and Wolfgang Nagel and Alexander Schill
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG benchmark_frequency benchmark_power frequency-power


source("ESEUR_config.r")

library("plyr")


# plot_layout(3, 1)


plot_alg=function(df)
{
plot(0, type="n",
	xlim=range(df$frequency), ylim=range(df$ac),
	xlab="Frequency (MHz)", ylab="Power (Joules)\n")

text(2000, max(df$ac), df$alg[1], cex=1.4)

d_ply(df, .(dsize), function(df) points(df$frequency, df$ac, col=pal_col[df$dsize/10]))

}


sort_power=read.csv(paste0(ESEUR_dir, "benchmark/thecostofsorting.csv.xz"), as.is=TRUE)

pal_col=rainbow(length(unique(sort_power$dsize)))

# plot_alg(subset(sort_power, alg == "Count"))

# d_ply(sort_power, .(alg), plot_alg)

radix=subset(sort_power, alg == "Radix")

plot_alg(radix)

# This is a really good fit
# r_mod=glm(ac ~ I(frequency^2):dsize+dsize, data=radix)
#
# This is an even better fit
# r_mod=glm(ac ~ I(frequency^2):dsize+frequency*dsize, data=radix)
# summary(r_mod)

