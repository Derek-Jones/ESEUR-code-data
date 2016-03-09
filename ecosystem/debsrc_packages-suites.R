#
# debsrc_packages-suites.R,  6 May 15
#
# Data from:
# Debsources: Live and Historical Views on Macro-Level Software Evolution∗
# Matthieu Caneill and Stefano Zacchirol
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")
library("survival")


# Get date of first/last date that package was included in a distribution
package_lifetime=function(df)
{
df=df[order(df$s_date), ]

return(data.frame(s_date=df$s_date[1], e_date=df$e_date[nrow(df)]))
}


# TODO
package_history=function(df)
{
df=df[order(df$date), ]
# Get the first occurrence of a version in the sequence
first_use=c(1, head(cumsum(rle(df$version)$lengths+1), -1))

}


# "package","version","suite"
packages=read.csv(paste0(ESEUR_dir, "ecosystem/debsrc_packages-suites.csv.xz"), as.is=TRUE)

# One day past date of files released with paper
last_date=as.Date("2014-03-17", format="%Y-%m-%d")

# suite,s_date
suite_date=read.csv(paste0(ESEUR_dir, "ecosystem/debsrc_suites.csv.xz"), as.is=TRUE)

s_date=as.Date(suite_date$s_date, format="%Y-%m-%d")
names(s_date)=suite_date$suite
e_date=c(s_date[-1], last_date)
names(e_date)=suite_date$suite

released=subset(packages, suite %in% suite_date$suite)
released$s_date=s_date[released$suite]
released$e_date=e_date[released$suite]

p_dates=ddply(released, .(package), package_lifetime)

suite_surv=Surv(as.numeric(p_dates$e_date)-as.numeric(p_dates$s_date),
                 event=p_dates$e_date != last_date, type="right")
suite_mod=survfit(suite_surv ~ 1)

plot(suite_mod, col="red",
	xlab="Days", ylab="Survival rate\n")


