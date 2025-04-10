#
# hotpower-sep.R, 13 Sep 16
# Data from:
# Accurate Characterization of the Variability in Power Consumption in Modern Mobile Processors
# Bharathan Balaji and John McCullough and Rajesh K. Gupta and Yuvraj Agarwal
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG benchmark_power power_variability power_accurate


source("ESEUR_config.r")

library("plyr")


power_bench=read.csv(paste0(ESEUR_dir, "regression/hotpower.csv.xz"), as.is=TRUE)

power_bench=subset(power_bench, subset=!grepl("cpuload", benchmark))

# Express in Gigahertz
power_bench$frequency=power_bench$frequency/1000000

power_bench$processor=as.factor(power_bench$processor)

brew_col=rainbow(6)

fit_and_plot=function(df)
{
points(df$frequency, df$meanpower, col=brew_col[as.numeric(df$processor)])

g_mod=glm(meanpower ~ frequency, data=df)

pred=predict(g_mod, type="response", se.fit=TRUE)

lines(df$frequency, pred$fit, col=brew_col[as.numeric(df$processor)])

return(g_mod)
}

plot(power_bench$frequency, power_bench$meanpower, type="n",
	xlab="Frequency (GHz)", ylab="Mean power (watts)")

d_ply(power_bench, .(processor), fit_and_plot)

# Separate out by benchmark
#plot(power_bench$frequency, power_bench$meanpower,
#	xlab="Frequency (GHz)", ylab="Mean power (watts)")
#
#d_ply(power_bench, .(benchmark), fit_and_plot)

