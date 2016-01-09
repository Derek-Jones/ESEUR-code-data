#
# hotpower-mixed.R, 22 Aug 14
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("lme4")
library("car")


power_bench=read.csv(paste0(ESEUR_dir, "regression/hotpower.csv.xz"), as.is=TRUE)

power_bench=subset(power_bench, subset=!grepl("cpuload", benchmark))

# Express in Gigahertz
power_bench$frequency=power_bench$frequency/1000000

power_bench$processor=as.factor(power_bench$processor)

# proc_mod=lmer(meanpower ~ frequency +(1 | processor), data=power_bench)
# proc_mod=lmer(meanpower ~ frequency +(frequency-1 | processor), data=power_bench)
proc_mod=lmer(meanpower ~ frequency +(frequency | processor), data=power_bench)

print(summary(proc_mod))


# library("sjPlot")
# 
# sjp.lmer(proc_mod)

