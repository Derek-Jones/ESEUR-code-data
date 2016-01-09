#
# Linux-logistic.R,  6 Nov 14
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("MASS")

ll=read.csv(paste0(ESEUR_dir, "regression/Linux-LOC.csv.xz"), as.is=TRUE)
ld=read.csv(paste0(ESEUR_dir, "regression/Linux-days.csv.xz"), as.is=TRUE)


loc_date=merge(ll, ld)

loc_date$Release_date=as.Date(loc_date$Release_date, format="%d-%b-%Y")
start_date=loc_date$Release_date[1]

loc_date$Number_days=as.integer(difftime(loc_date$Release_date,
                                         start_date,
                                         units="days"))

ld_ordered=loc_date[order(loc_date$Release_date), ]

strip_support_v=function(version_date, step)
{
v=substr(version_date$Version, 1, 3)
q=c(rep(TRUE, step), v[1:(length(v)-step)] <= v[(1+step):length(v)])
return (version_date[q, ])
}



h1=strip_support_v(ld_ordered, 1)
all_days=strip_support_v(h1, 5)

# If 3000 is used the following error appears:
# step factor 0.000488281 reduced below 'minFactor' of 0.000976562
# This is probably due to the initial values chosen, it is
# simpler to include a few more points than fiddle around with tuning value.
first_3000=subset(all_days, Number_days <= 3400)

x_bounds=0:6000

plot(all_days$Number_days, all_days$LOC, col=point_col,
	xlim=range(x_bounds),
	xlab="Days", ylab="Total lines of code\n")


# m3=nls(LOC ~ SSfpl(Number_days, a, b, c, d), data=first_3000)
# y=predict(m3, list(Number_days=x_bounds))

# lines(x_bounds, y, col="blue")

# m3=nls(LOC ~ a+(b-a)/(1+exp((c-Number_days)/d)), data=all_days,
#                  start=list(a=-3e+05, b=4e+6, c=2000, d=800))

m3=nls(LOC ~ SSfpl(Number_days, a, b, c, d), data=all_days)
y=predict(m3, list(Number_days=x_bounds))

lines(x_bounds, y, col="red")


