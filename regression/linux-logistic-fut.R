#
# Linux-logistic-fut.R, 23 Dec 15
# Data from:
# The {Linux} Kernel as a Case Study in Software Evolution
# Ayelet Israeli and Dror G. Feitelson
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(4)

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

x_bounds=0:6000

plot(all_days$Number_days, all_days$LOC, col=point_col,
	xlim=range(x_bounds),
	xlab="Days since version 1.0 release", ylab="Total lines of code\n")

plot_subset=function(max_days, col_num)
{
first_3000=subset(all_days, Number_days <= max_days)

m3=nls(LOC ~ SSfpl(Number_days, a, b, c, d), data=first_3000)
y=predict(m3, list(Number_days=x_bounds))

lines(x_bounds, y, col=pal_col[col_num])
}


# For some values of Number_days the following error occurs:
# step factor 0.000488281 reduced below 'minFactor' of 0.000976562
# It is simpler to find values that work than fiddle around
# with tuning start values.

plot_subset(2900, 1)
plot_subset(3650, 2)
plot_subset(4200, 3)
plot_subset(max(all_days$Number_days), 4)

