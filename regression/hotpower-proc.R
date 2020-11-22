#
# hotpower-proc.R, 21 Jan 14
# Accurate Characterization of the Variability in Power Consumption in Modern Mobile Processors
# Bharathan Balaji and John McCullough and Rajesh K. Gupta and Yuvraj Agarwal
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG benchmark_power power_variability power_accurate

source("ESEUR_config.r")


power_bench=read.csv(paste0(ESEUR_dir, "regression/hotpower.csv.xz"), as.is=TRUE)

power_bench=subset(power_bench, subset=!grepl("cpuload", benchmark))

# Express in Gigahertz
power_bench$frequency=power_bench$frequency/1000000

power_bench$processor=as.factor(power_bench$processor)

proc_mod=glm(meanpower ~ frequency*processor, data=power_bench)

summary(proc_mod)

# library("sjPlot")
# 
# sjp.lm(proc_mod)

