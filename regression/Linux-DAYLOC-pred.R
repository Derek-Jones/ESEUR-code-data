#
# Linux-DAYLOC-pred.R, 14 Mar 20
# Data from:
# The {Linux} Kernel as a Case Study in Software Evolution
# Ayelet Israeli and Dror G. Feitelson
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Linux_evolution LOC_evolution

source("ESEUR_config.r")


pal_col=rainbow(3)

# Lines of code in each release
ll=read.csv(paste0(ESEUR_dir, "regression/Linux-LOC.csv.xz"), as.is=TRUE)
# Data of each release
ld=read.csv(paste0(ESEUR_dir, "regression/Linux-days.csv.xz"), as.is=TRUE)

loc_date=merge(ll, ld)

# Add column giving number of days since first release
loc_date$Release_date=as.Date(loc_date$Release_date, format="%d-%b-%Y")
start.date=loc_date$Release_date[1]
loc_date$Number_days=as.integer(difftime(loc_date$Release_date,
                                         start.date,
                                         units="days"))
# Order by days since first release
ld_ordered=loc_date[order(loc_date$Number_days), ]

# What is the latest version
n_Version=numeric_version(ld_ordered$Version)

# cummax does not work for numeric_version, so we
# have to track the latest version
greatest_version <<- n_Version[1]

keep_version=sapply(2:nrow(ld_ordered),
		function(X)
		{
		if (n_Version[X] > greatest_version)
		   {	
		   greatest_version <<- n_Version[X]
		   return(TRUE)
		   }
		return(FALSE)
		})

latest_version=ld_ordered[c(TRUE, keep_version), ]


plot_conf_int=function(mod, x)
{
# linear model with confidence intervals plotted
prd=predict(mod, newdata=list(Number_days=x), se.fit=TRUE)
summary(prd$fit)
lines(x, prd$fit-1.96*prd$se.fit, col=pal_col[1], lty=2)
lines(x, prd$fit+1.96*prd$se.fit, col=pal_col[1], lty=2)
}


latest_version$MLOC=latest_version$LOC/1e6
y_lim=c(1, max(latest_version$MLOC))

m3=glm(MLOC ~ Number_days+I(Number_days^2)+I(Number_days^3), data=latest_version)

the_future=3000:7500
future_range=range(the_future)

plot(latest_version$Number_days, latest_version$MLOC, col=pal_col[2],
	yaxs="i",
	xlim=future_range, ylim=y_lim,
	xlab="Days", ylab="Total lines of code (MLOC)\n")


y=predict(m3, newdata=list(Number_days=the_future))

lines(the_future, y, col=pal_col[1])

plot_conf_int(m3, the_future)

lines(c(max(latest_version$Number_days), max(latest_version$Number_days)),
      c(0, max(latest_version$MLOC)), col=pal_col[3])

