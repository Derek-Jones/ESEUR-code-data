#
# feat-half-day-7dig.R, 20 Feb 16
#
# Various analysis of http://www.7digital.com feature data
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("fitdistrplus")

source(paste0(ESEUR_dir, "projects/agile-work/feat-common-7dig.R"))

Done_day=as.integer(p$Done)-base_day


fit_quality=function(half_day_list)
{
fd=fitdist(half_day_list, "nbinom", method="mme")
return(c(loglikelihood=fd$loglik, AIC=fd$aic, BIC=fd$bic))
}


sub_divide=function(cycle_list)
{
cl=length(cycle_list)
dither=as.integer(runif(cl, 0, 1) > 0.33)
return(2*cycle_list-dither)
}


fit_quality(p$Cycle.Time[Done_day < 650])
rowMeans(replicate(1000, fit_quality(sub_divide(p$Cycle.Time[Done_day < 650]))))

