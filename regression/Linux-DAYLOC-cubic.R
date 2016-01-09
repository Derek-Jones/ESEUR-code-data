#
# Linux-DAYLOC-cubic.R, 15 Mar 14
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

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
		else
		   return(FALSE)
		})

latest_version=ld_ordered[c(TRUE, keep_version), ]


plot_conf_int=function(mod, x)
{
# linear model with confidence intervals plotted
prd=predict(mod, newdata=list(Number_days=x), interval = "confidence", level = 0.95)
summary(prd)
lines(x, prd[,2], col="red", lty=2)
lines(x, prd[,3], col="red", lty=2)
}


x_lim=c(1, max(latest_version$Number_days))
y_lim=c(1, max(latest_version$LOC))

m3=glm(LOC ~ Number_days+I(Number_days^2)+I(Number_days^3), data=latest_version)

print(summary(m3))

