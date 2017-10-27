#
# feat_duration-7dig.R, 26 Oct 17
#
# Data from:
# http://www.7digital.com feature data
# Rob Bowley
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#

source("ESEUR_config.r")


# Needed to prevent
# Error: ‘x’ object of class REBMIX is requested!
# When book is built
unloadNamespace("rebmix")

# Fit a zero-truncated negative binomial distribution
library(gamlss)
library(gamlss.tr)

plot_layout(2, 1)


source(paste0(ESEUR_dir, "projects/agile-work/feat-common-7dig.R"))

Done_day=as.integer(p$Done)-base_day

# We need to explicitly specify where the distribution is to be truncated
gen.trun(par=0, family=NBII)


# Fit a zero-truncated, type II, negative binomial distribution
fit.NBII=function(day_list)
{
g_NBIItr=gamlss(day_list ~ 1, family=NBIItr)

# print(summary(g_NBIItr))

NBII_mu=exp(coef(g_NBIItr, "mu"))
NBII_sigma=exp(coef(g_NBIItr, "sigma"))

# print(c(NBII_mu, NBII_sigma))

plot(table(day_list), type="p", log="xy", col=point_col,
	xlim=c(1, 90), ylim=c(1, 1200),
	xlab="Elapsed working days", ylab="Feature count\n")

lines(dNBIItr(1:93, mu=NBII_mu, sigma=NBII_sigma)*length(day_list), col="red")
return(c(AIC=as.numeric(AIC(g_NBIItr)),
         log_likelihood=as.numeric(logLik(g_NBIItr))))
}


qual_pre650=fit.NBII(p$Cycle.Time[Done_day <= 650])
qual_post650=fit.NBII(p$Cycle.Time[Done_day > 650])


