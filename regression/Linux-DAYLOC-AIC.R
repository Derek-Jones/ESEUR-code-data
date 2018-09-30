#
# Linux-DAYLOC-AIC.R, 15 Mar 14
# Data from:
# The {Linux} Kernel as a Case Study in Software Evolution
# Ayelet Israeli and Dror G. Feitelson
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Linux evolution


source("ESEUR_config.r")


# May have been install by previous programs and defines its own AIC function!
unloadNamespace("rebmix")
# detach(package:rebmix)

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

m1=glm(LOC ~ Number_days, data=latest_version)
m2=glm(LOC ~ Number_days+I(Number_days^2), data=latest_version)
m3=glm(LOC ~ Number_days+I(Number_days^2)+I(Number_days^3), data=latest_version)
m4=glm(LOC ~ Number_days+I(Number_days^2)+I(Number_days^3)+I(Number_days^4), data=latest_version)

print(paste0("Degree 1, AIC= ", AIC(m1)), quote=FALSE)
print(paste0("Degree 2, AIC= ", AIC(m2)), quote=FALSE)
print(paste0("Degree 3, AIC= ", AIC(m3)), quote=FALSE)
print(paste0("Degree 4, AIC= ", AIC(m4)), quote=FALSE)

# m4=glm(LOC ~ poly(Number_days, degree=4), data=latest_version)
