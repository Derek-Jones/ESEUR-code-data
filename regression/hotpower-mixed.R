#
# hotpower-mixed.R, 11 Sep 16
# Data from:
# Accurate Characterization of the Variability in Power Consumption in Modern Mobile Processors
# Bharathan Balaji and John McCullough and Rajesh K. Gupta and Yuvraj Agarwal
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG power_variability cpu_power


source("ESEUR_config.r")

library("lme4")


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

print(summary(proc_mod))

