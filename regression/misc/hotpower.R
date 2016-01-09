#
# hotpower.R, 20 Jan 14
#
# Data from:
# Accurate Characteristization of the Variability in Power Consumption in Modern Mobile Processor
# Bharathan Balaji and John McCullough and Rajesh K. Gupta and Yuvraj Agarwal
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("lme4")

power_bench=read.csv(paste0(ESEUR_dir, "regression/hotpower.csv.xz"), as.is=TRUE)

power_bench=subset(power_bench, subset=!grepl("cpuload", benchmark))

power_bench$processor=as.factor(power_bench$processor)

# Express in Gigahertz
power_bench$frequency=power_bench$frequency/1000000

brew_col=rainbow_hcl(6)


plot(power_bench$frequency, power_bench$meanpower,
	xlab="Frequency (GHz)", ylab="Mean power (watts)")

p_mod=lmer(meanpower ~ frequency + (frequency | benchmark) + (frequency | processor),
		data=power_bench)


p_mod=lmer(meanpower ~ frequency + (1 | benchmark) + (1 | processor),
		data=power_bench)


g_mod=glm(meanpower ~ frequency, data=power_bench)

gp_mod=glm(meanpower ~ frequency+processor, data=power_bench)



