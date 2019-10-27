#
# SiP-task-estact.R, 26 Oct 19
# Data from:
# Stephen Cullum
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG estimating effort company


source("ESEUR_config.r")


library("bizdays")
library("lubridate")
library("plyr")


Sip_all=read.csv(paste0(ESEUR_dir, "projects/Sip-task-info.csv.xz"), as.is=TRUE)
Sip_date=read.csv(paste0(ESEUR_dir, "projects/est-act-dates.csv.xz"), as.is=TRUE)
Sip_date$EstimateOn=as.Date(Sip_date$EstimateOn, format="%d-%b-%y")
Sip_date$StartedOn=as.Date(Sip_date$StartedOn, format="%d-%b-%y")
Sip_date$CompletedOn=as.Date(Sip_date$CompletedOn, format="%d-%b-%y")

Sip_date=Sip_date[order(Sip_date$TaskNumber), ]
Sip_date$TaskNumber=NULL
Sip_all=cbind(Sip_all, Sip_date)

# sanity checks
# range(Sip_date$EstimateOn)
# table(diff(Sip_all$EstimateOn))
# table(Sip_all$StartedOn-Sip_all$EstimateOn)
# tt=table(Sip_all$CompletedOn-Sip_all$StartedOn)

# Removed the 190 tasks that were cancelled before completion
Sip=subset(Sip_all, StatusCode != "CANCELLED")
# Single instance of this in the data
Sip=subset(Sip, StatusCode != "TEMPLATE")
Sip_stTN=subset(Sip, !duplicated(TaskNumber))
# Projects that were not completed at the time of the data snapshot
Sip=subset(Sip, StatusCode != "CHRONICLE")

Sip_uTN=subset(Sip, !duplicated(TaskNumber))

# Use of round numbers

Est_t=count(Sip_uTN$HoursEstimate)
Act_t=count(Sip_uTN$HoursActual)


pal_col=rainbow(2)

Est_m=subset(Est_t, freq > 5)
plot(Est_m$x*1.01, Est_m$freq, log="x", type="h", col=pal_col[1],
	yaxs="i",
	xlim=c(0.5, 50), ylim=c(5, 1400),
	xlab="Hours", ylab="Tasks\n")

Act_m=subset(Act_t, freq > 5)
points(Act_m$x*0.99, Act_m$freq, type="h", col=pal_col[2])

legend(x="topright", legend=c("Estimate", "Actual"), bty="n", fill=pal_col, cex=1.2)

