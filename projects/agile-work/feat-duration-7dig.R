#
# feat_duration-7dig.R, 10 Oct 19
#
# Data from:
# http://www.7digital.com feature data
# Rob Bowley
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Agile_feature Agile_elapsed-time feature_elapsed day_working

source("ESEUR_config.r")


pal_col=rainbow(3)

# Needed to prevent
# Error: ‘x’ object of class REBMIX is requested!
# When book is built
unloadNamespace("rebmix")

# Fit a zero-truncated negative binomial distribution
library(gamlss)
library(gamlss.tr)


source(paste0(ESEUR_dir, "projects/agile-work/feat-common-7dig.R"))

Done_day=as.integer(p$Done)-base_day

# We need to explicitly specify where the distribution is to be truncated
gen.trun(par=0, family=NBII)


# Fit a zero-truncated, type II, negative binomial distribution
fit.NBII=function(day_list, col_num)
{
g_NBIItr=gamlss(day_list ~ 1, family=NBIItr)

# print(summary(g_NBIItr))

NBII_mu=exp(coef(g_NBIItr, "mu"))
NBII_sigma=exp(coef(g_NBIItr, "sigma"))

# print(c(NBII_mu, NBII_sigma))

points(table(day_list), type="p", col=pal_col[col_num])

lines(dNBIItr(1:93, mu=NBII_mu, sigma=NBII_sigma)*length(day_list), col=pal_col[2])
return(c(AIC=as.numeric(AIC(g_NBIItr)),
         log_likelihood=as.numeric(logLik(g_NBIItr))))
}


plot(0.1, type="n", log="xy",
	yaxs="i",
	xlim=c(1, 90), ylim=c(1, 1000),
	xlab="Elapsed working days", ylab="Feature count\n")

legend(x="topright", legend=c("First 650 days", "After 650 days"), bty="n", fill=pal_col, cex=1.2)

qual_pre650=fit.NBII(p$Cycle.Time[Done_day <= 650], 1)
qual_post650=fit.NBII(p$Cycle.Time[Done_day > 650], 3)


