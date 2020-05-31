#
# 2002-09989.R, 20 May 20
# Data from:
# Deriving a Usage-Independent Software Quality Metric
# Tapajit Dey and Audris Mockus
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG application_usage application_exceptions usage_exceptions

source("ESEUR_config.r")


pal_col=rainbow(2)


get_App=function(App_id)
{
t=subset(ua, App == App_id)
return(subset(t, timeOnSite > 0))
}

# Application information
# 36442576 AC-Android
#   UA-36442576-1 AC-Android Pre-GA
#     66275034 AC-Android Pre-GA All Mobile App Data
#   UA-36442576-3 AC-Android Experimental
#     72444718 AC-Android Experimental All Mobile App Data
#   UA-36442576-4 AC-Android GA
#     79349574 AC-Android GA All Mobile App Data
#   UA-36442576-5 AC-Android Dev
#     79912722 AC-Android Dev All Mobile App Data
#     99871005 AC-Android 2.1.1_566 Mobile App Data (begins Mar 24)
# 40745335 1xmsipios
#   UA-40745335-1 1XM SIP iOS
#     72167750 All Mobile App Data
#   UA-40745335-2 1XM SIP iOS Beta
#     79648078 1XM SIP iOS Beta All Mobile App Data
#   UA-40745335-3 1XM SIP iOS GA
# s    80694328 1XM SIP iOS GA All Mobile App Data
# 44698255 Avaya Mobile Apps
#   UA-44698255-1 ScsCommander
#     77543105 All Mobile App Data
# 56161929 AC-iPhone
#   UA-56161929-1 Avaya Communicator for iPhone
#     93054549 All Mobile App Data
#     104869929 Only App Version 2.1 Data
#   UA-56161929-2 Communicator analytics test
#     112953277 All Mobile App Data

ua=read.csv(paste0(ESEUR_dir, "reliability/2002-09989.csv.xz"), as.is=TRUE, sep=";")

ua$date=as.Date(as.character(ua$date), format="%Y%m%d")

# table(ua$App)

a36=get_App(36442576)
a36$GA=mapvalues(a36$relApp, c(1, 3, 4, 5),
				 c("Pre-GA", "Experimental", "GA", "Dev"))

# a44=get_App(44698255)

# a36_mod=glm(exceptions ~ sqrt(timeOnSite)*(log(newVisits+0.1)+log(visits))
# 			+GA
# 			+operatingSystemVersion,
# 					family=poisson, data=a36)
# 
# summary(a36_mod)

pre_GA=subset(a36, GA == "Pre-GA")

plot(pre_GA$newVisits, pre_GA$exceptions, col=pal_col[2], log="xy",
	xlab="New visitors (per day)", ylab="Exceptions (per day)\n")

a36_smod=glm(exceptions ~ log(newVisits+0.1), family=poisson, data=pre_GA)
x_vals=exp(seq(0, log(max(a36$newVisits)), by=0.1))
pred=predict(a36_smod, newdata=data.frame(newVisits=x_vals))
lines(x_vals, exp(pred), col=pal_col[1])

# Not many exceptions, but the model looks good
# a40=get_App(40745335)
# a40_mod=glm(exceptions ~ log(timeOnSite)+log(newVisits+0.1)+log(visits)
# 			+operatingSystemVersion,
# 					family=poisson, data=a40)
# 
# summary(a40_mod)
# 
# 
# 
