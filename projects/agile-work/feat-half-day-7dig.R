#
# feat-half-day-7dig.R, 25 Aug 12
#
# Various analysis of http://www.7digital.com feature data
#
# R code for book "Empirical Software Engineering using R"
# Derek M. Jones, http://shape-of-code.coding-guidelines.com
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("fitdistrplus")


p=read.csv(paste0(ESEUR_dir, "projects/agile-work/7digital2012.csv.xz"))

# Bracket the data start/end dates
base.date="20/04/2009"  # a Monday
base.day=as.integer(as.Date(base.date, "%d/%m/%Y"))
end.day=as.integer(as.Date("01/08/2012", "%d/%m/%Y"))-base.day

Done.day=as.integer(as.Date(p$Done, format="%d/%m/%Y"))-base.day


fit.quality=function(half.day.list)
{
fd=fitdist(half.day.list, "nbinom", method="mme")
return(c(loglikelihood=fd$loglik, AIC=fd$aic, BIC=fd$bic))
}


sub.divide=function(cycle.list)
{
cl=length(cycle.list)
dither=as.integer(runif(cl, 0, 1) > 0.33)
return(2*cycle.list-dither)
}


#fit.quality(p$Cycle.Time[Done.day < 650])
#rowMeans(replicate(1000, fit.quality(sub.divide(p$Cycle.Time[Done.day < 650]))))

