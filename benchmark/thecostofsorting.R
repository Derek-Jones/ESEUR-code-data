#
# thecostofsorting.R,  3 Feb 16
#
# Data from:
#
# Energy-Efficient Data Processing at Sweet Spot Frequencies
# Sebastian G{\"o}tz and Thomas Ilsche and Jorge Cardoso and Josef Spillner and Uwe A{\ss}mann and Wolfgang Nagel and Alexander Schill
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("plyr")


plot_layout(3, 1)


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

d_ply(sort_power, .(alg), plot_alg)


