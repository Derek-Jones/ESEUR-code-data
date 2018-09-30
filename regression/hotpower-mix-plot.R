#
# hotpower-mix-plot.R, 26 Sep 16
# Data from:
# Accurate Characterization of the Variability in Power Consumption in Modern Mobile Processors
# Bharathan Balaji and John McCullough and Rajesh K. Gupta and Yuvraj Agarwal
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG power-consumption processor benchmark


source("ESEUR_config.r")

unloadNamespace("ordinal") # defines a ranef

library("lattice")
library("lme4")
library("gridExtra")


# The processor configuration data analysed here is a small subset of the
# measurements made:
# Turbo Boost off, C states enabled, Hyper-Threading off

power_bench=read.csv(paste0(ESEUR_dir, "regression/hotpower.csv.xz"), as.is=TRUE)

power_bench=subset(power_bench, subset=!grepl("cpuload", benchmark))

# Express in Gigahertz
power_bench$frequency=power_bench$frequency/1000000

power_bench$processor=as.factor(power_bench$processor)

# proc_mod=lmer(meanpower ~ frequency +(1 | processor), data=power_bench)
# proc_mod=lmer(meanpower ~ frequency +(frequency-1 | processor), data=power_bench)
proc_mod=lmer(meanpower ~ frequency +(frequency | processor), data=power_bench)


dp_orig=dotplot(ranef(proc_mod, condVar=TRUE), main=FALSE, aspect=1.2)
#print(t) # plot generates an error

power_bench$shift_freq=power_bench$frequency-min(power_bench$frequency)
proc_mod=lmer(meanpower ~ shift_freq +(shift_freq | processor), data=power_bench)
# summary(proc_mod)

dp_shift=dotplot(ranef(proc_mod, condVar=TRUE), main=FALSE, aspect=1.2)
# plot(dp_shift[[1]])

# dotplot comes from the lattice package which uses grid layout :-(

grid.arrange(dp_orig$processor, dp_shift$processor, nrow=2)


# shift_mod=lmer(meanpower ~ shift_freq +(shift_freq-1 | processor), data=power_bench)
# summary(shift_mod)

