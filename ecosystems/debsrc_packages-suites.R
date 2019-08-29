#
# debsrc_packages-suites.R, 26 Aug 19
#
# Data from:
# Debsources: Live and Historical Views on Macro-Level Software Evolution∗
# Matthieu Caneill and Stefano Zacchirol
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Debian_package package_survival package_version


source("ESEUR_config.r")


library("plyr")
library("survival")


pal_col=rainbow(2)


# Get first/last date that package was included in a distribution
package_lifetime=function(df)
{
return(data.frame(s_date=min(df$s_date), e_date=max(df$e_date)))
}


# "package","version","suite"
packages=read.csv(paste0(ESEUR_dir, "ecosystems/debsrc_packages-suites.csv.xz"), as.is=TRUE)

# One day past date of files released with paper
last_date=as.Date("2014-03-17", format="%Y-%m-%d")

# suite,s_date
suite_date=read.csv(paste0(ESEUR_dir, "ecosystems/debsrc_suites.csv.xz"), as.is=TRUE)

s_date=as.Date(suite_date$s_date, format="%Y-%m-%d")
names(s_date)=suite_date$suite
e_date=c(s_date[-1], last_date)
names(e_date)=suite_date$suite

released=subset(packages, suite %in% suite_date$suite)
released$s_date=s_date[released$suite]
released$e_date=e_date[released$suite]

p_dates=ddply(released, .(package), package_lifetime)

suite_surv=Surv(as.numeric(p_dates$e_date)-as.numeric(p_dates$s_date),
                 event=(p_dates$e_date != last_date), type="right")
suite_mod=survfit(suite_surv ~ 1)

plot(suite_mod, col=pal_col[1],
	yaxs="i",
	xlab="Days", ylab="Survival rate\n")


pv_dates=ddply(released, .(package, version), package_lifetime)

suite_surv=Surv(as.numeric(pv_dates$e_date)-as.numeric(pv_dates$s_date),
                 event=(pv_dates$e_date != last_date), type="right")
suite_mod=survfit(suite_surv ~ 1)

lines(suite_mod, col=pal_col[2])

legend(x="topright", legend=c("Package (latest version)", "Package (any version)"), bty="n", fill=pal_col, cex=1.2)

