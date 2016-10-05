#
# linux-nonint-poly.R, 14 Mar 14
# Data from:
# The {Linux} Kernel as a Case Study in Software Evolution
# Ayelet Israeli and Dror G. Feitelson
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


ll=read.csv(paste0(ESEUR_dir, "regression/Linux-LOC.csv.xz"), as.is=TRUE)
ld=read.csv(paste0(ESEUR_dir, "regression/Linux-days.csv.xz"), as.is=TRUE)


loc_date=merge(ll, ld)

loc_date$Release_date=as.Date(loc_date$Release_date, format="%d-%b-%Y")
start.date=loc_date$Release_date[1]

loc_date$Number_days=as.integer(difftime(loc_date$Release_date,
                                         start.date,
                                         units="days"))

ld.ordered=loc_date[order(loc_date$Release_date), ]

strip_support_v=function(version.date, step)
{
v=substr(version.date$Version, 1, 3)
q=c(rep(TRUE, step), v[1:(length(v)-step)] <= v[(1+step):length(v)])
return (version.date[q, ])
}

plot_conf_int=function(mod, x)
{
# linear model with confidence intervals plotted
prd=predict(mod, newdata=data.frame(x=x), interval = "confidence", level = 0.90)
lines(newx, prd[,2], col="red",lty=2)
lines(newx, prd[,3], col="red",lty=2)
}



h1=strip_support_v(ld.ordered, 1)
h2=strip_support_v(h1, 5)


# plot(h2$Number_days, h2$LOC, col=point_col,
#        xlab="Days", ylab="Total lines of code")


m1=nls(LOC ~ a+b*Number_days+Number_days^c, data=h2,
                 start=list(a=3e+05, b=-4e+2, c=2))

# x=1:5000
# y=predict(m1, list(Number_days=x))

# lines(x, y, col="red")

print(summary(m1))
print(paste("AIC = ", AIC(m1)))

