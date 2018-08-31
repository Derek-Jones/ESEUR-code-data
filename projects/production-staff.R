#
# production-staff.R, 12 Aug 18
# Model from:
# Staffing Implications of Software Productivity Models
# R. C. Tausworthe
#
# Example from:
# Evidence-based Software Engineering: based on the available public data
# Derek M. Jones
#
# TAG project staffing productivity model


source("ESEUR_config.r")


pal_col=rainbow(3)

staff_bounds=1:20

t0=0.1
t1=0.1
alpha=0.8

prod_rate=staff_bounds*(1-t0*(staff_bounds-1))

plot(staff_bounds, prod_rate, type="l", col=pal_col[3],
	yaxs="i",
	ylim=c(0, 5),
	xlab="Team size (people)", ylab="Rate of production")

prod_rate=staff_bounds*(1-t0*(staff_bounds^alpha-1))
lines(staff_bounds, prod_rate, col=pal_col[1])

prod_rate=staff_bounds*(exp(-t1*(staff_bounds-1)))
lines(staff_bounds, prod_rate, col=pal_col[2])

lines(staff_bounds, staff_bounds)

legend(x="bottomleft", legend=c("Power=0.8", "Exponential", "Linear"), bty="n", fill=pal_col, cex=1.2)


