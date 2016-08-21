#
# cpu-product-lifetime.R,  4 Jul 16
#
# Data from:
#
# http://www.cpushack.com/life-cycle-of-cpu.html
# John Culver
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)


bench=read.csv(paste0(ESEUR_dir, "ecosystem/cpu-product-lifetime.csv.xz"), as.is=TRUE)

plot(bench$Introduced, bench$Lifetime, col=point_col,
		xlab="Year introduced", ylab="Lifetime")

years=min(bench$Introduced):max(bench$Introduced)

lines(years, 2000-years, col=pal_col[1])
lines(years, 2010-years, col=pal_col[2])

