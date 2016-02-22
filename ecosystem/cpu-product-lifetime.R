#
# cpu-product-lifetime.R,  9 Feb 16
#
# Data from:
#
# http://www.cpushack.com/life-cycle-of-cpu.html
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


bench=read.csv(paste0(ESEUR_dir, "ecosystem/cpu-product-lifetime.csv"), as.is=TRUE)

plot(bench$Introduced, bench$Lifetime,
		xlab="Year introduced", ylab="Lifetime")

years=min(bench$Introduced):max(bench$Introduced)

lines(years, 2010-years)
lines(years, 2000-years)

