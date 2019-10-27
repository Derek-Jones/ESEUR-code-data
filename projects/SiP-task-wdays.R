#
# SiP-task-wdays.R, 10 Oct 19
# Data from:
# A conversation around the analysis of the {SiP} effort estimation dataset
# Derek M. Jones and Stephen Cullum
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Agile tasks duration_days company

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

# Removed the 190 tasks that were cancelled before completion
Sip=subset(Sip_all, StatusCode != "CANCELLED")
# Single instance of this in the data
Sip=subset(Sip, StatusCode != "TEMPLATE")
Sip_stTN=subset(Sip, !duplicated(TaskNumber))
# Projects that were not completed at the time of the data snapshot
Sip=subset(Sip, StatusCode != "CHRONICLE")

Sip_uTN=subset(Sip, !duplicated(TaskNumber))


# P 16

# Working days patterns

pal_col=rainbow(2)

bankhol=read.csv(paste0(ESEUR_dir, "projects/ukbankholidays.csv.xz"), as.is=TRUE)
bankhol$UK.BANK.HOLIDAYS=as.Date(bankhol$UK.BANK.HOLIDAYS, format="%d-%b-%Y")

create.calendar("UK", bankhol$UK.BANK.HOLIDAYS, weekdays=c("saturday", "sunday"))

days=exp(seq(0.0, 10, by =0.1))
# There is a bizdays in forecast!
task_dur=bizdays::bizdays(Sip_uTN$StartedOn, Sip_uTN$CompletedOn, "UK")
tab_td=count(task_dur)
tab_td=subset(tab_td, x > 0)

plot(tab_td$x, tab_td$freq, log="xy", col=pal_col[1],
	xlab="Working days", ylab="Tasks\n")
dur_mod=glm(log(freq) ~ log(x), data=tab_td)
summary(dur_mod)
pred=predict(dur_mod, newdata=data.frame(x=days))
lines(days, exp(pred), col=pal_col[1])
 

task_wait=bizdays::bizdays(Sip_uTN$EstimateOn, Sip_uTN$StartedOn, "UK")
tab_tw=count(task_wait)
tab_tw=subset(tab_tw, x > 0)

# plot(tab_tw$x, tab_tw$freq, log="xy", col=pal_col[2],
# 	xlab="Start waiting (working days)", ylab="Tasks\n")
points(tab_tw$x, tab_tw$freq, col=pal_col[2])

# There is a long tail that skews the majority fit, unless truncated
tab_tw=subset(tab_tw, x < 100) # as good a number as any
wait_mod=glm(log(freq) ~ log(x), data=tab_tw)
# wait_mod=glm(log(freq) ~ log(x)+I(log(x)^-1.5), data=tab_tw)
summary(wait_mod)
pred=predict(wait_mod, newdata=data.frame(x=days))
lines(days, exp(pred), col=pal_col[2])

legend(x="topright", legend=c("Start-complete", "Estimate-start"), bty="n", fill=pal_col, cex=1.2)

