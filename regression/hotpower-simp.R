#
# hotpower-simp.R, 21 Jan 14
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


power_bench=read.csv(paste0(ESEUR_dir, "regression/hotpower.csv.xz"), as.is=TRUE)

power_bench=subset(power_bench, subset=!grepl("cpuload", benchmark))

# Express in Gigahertz
power_bench$frequency=power_bench$frequency/1000000

power_bench$processor=as.factor(power_bench$processor)

simple_mod=glm(meanpower ~ frequency, data=power_bench)

print(summary(simple_mod))

