#
# cpu-product-lifetime.R, 22 Apr 20
#
# Data from:
# http://www.cpushack.com/life-cycle-of-cpu.html
# John Culver
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG lifetime_cpu


source("ESEUR_config.r")


pal_col=rainbow(3)


bench=read.csv(paste0(ESEUR_dir, "ecosystems/cpu-product-lifetime.csv.xz"), as.is=TRUE)

plot(bench$Introduced, bench$Lifetime, col=pal_col[2],
		yaxs="i",
		xlab="Year introduced", ylab="Lifetime (years)\n")

years=min(bench$Introduced):max(bench$Introduced)

lines(years, 2000-years, col=pal_col[1])
lines(years, 2010-years, col=pal_col[3])

