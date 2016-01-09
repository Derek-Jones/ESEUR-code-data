#
# feat-zero-trunc-nb-7dig.R, 30 Dec 15
#
# Data from:
# http://www.7digital.com feature data
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


par(mfcol=c(2,1))

p=read.csv(paste0(ESEUR_dir, "projects/7digital2012.csv.xz"), as.is=TRUE)

# Bracket the data start/end dates
base.date="20/04/2009"  # a Monday
base.day=as.integer(as.Date(base.date, "%d/%m/%Y"))
end.day=as.integer(as.Date("01/08/2012", "%d/%m/%Y"))-base.day

# Calculate weekend days so they can be removed from totals.
# base.day is a Monday, so first Saturday starts at day 5
weekends=c(seq(5, end.day ,by=7), # Saturday
           seq(6, end.day, by=7))
Done.day=as.integer(as.Date(p$Done, format="%d/%m/%Y"))-base.day


library(gamlss)
library(gamlss.tr)

# We need to explicitly specify where the distribution is to be truncated
gen.trun(par=0, family=NBII)


# Fit a zero-truncated, type II, negative binomial distribution
fit.NBII=function(day.list)
{
g.NBIItr=gamlss(day.list ~ 1, family=NBIItr)

NBII.mu=exp(coef(g.NBIItr, "mu"))
NBII.sigma=exp(coef(g.NBIItr, "sigma"))

plot(table(day.list), xlim=c(1, 90), ylim=c(1, 1200), log="xy", type="p",
            xlab="Elapsed working days", ylab="Feature count")

lines(dNBIItr(1:93, mu=NBII.mu, sigma=NBII.sigma)*length(day.list), col="red")

return(c(AIC=as.numeric(AIC(g.NBIItr)),
         log.likelihood=as.numeric(logLik(g.NBIItr))))
}


qual.pre650=fit.NBII(p$Cycle.Time[Done.day <= 650])
qual.post650=fit.NBII(p$Cycle.Time[Done.day > 650])
