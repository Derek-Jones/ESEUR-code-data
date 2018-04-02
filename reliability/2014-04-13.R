#
# 2014-04-13.R, 23 Feb 18
# Data from:
# Measuring commercial software operational reliability: an interdisciplinary modelling approach
# Omar Shatnawi
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

# For Date 19, change Site 91 -> 19
# All values, except Date, are a percentage of the maximum value.
fails=read.csv(paste0(ESEUR_dir, "reliability/2014-04-13.csv.xz"), as.is=TRUE)

fails$SW_f_per_t=c(0, diff(fails$cum.SW.fail))
fails$use_f_per_t=c(0, diff(fails$cum.usage.fail))

plot(~ Date+SW_f_per_t+use_f_per_t+cum.SW.fail+cum.usage.fail+ Site, data=fails)

# SW_f_mod=glm(SW_f_per_t ~ Date:Site+Site, data=fails, family=poisson)
# SW_f_mod=glm(SW_f_per_t ~ log(Date+Site), data=fails, family=poisson(link="identity"))
# SW_f_mod=glm(SW_f_per_t ~ Date+Site+cum.usage.fail, data=fails, family=poisson)

SW_f_mod=glm(SW_f_per_t ~ Date+Site, data=fails, family=poisson)
summary(SW_f_mod)


