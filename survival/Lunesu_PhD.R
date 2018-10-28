#
# Lunesu_PhD.R, 13 Oct 18
# Data from:
# Process Software Simulation Model of {Lean-Kanban} Approach
# Maria Ilaria Lunesu
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG maintenance issues evolution

source("ESEUR_config.r")


library("survival")

plot_layout(2, 1)
pal_col=rainbow(3)


Lun=read.csv(paste0(ESEUR_dir, "survival/Lunesu_PhD.csv.xz"), as.is=TRUE)

Lun$Report.Date=as.Date(Lun$Report.Date, format="%m/%d/%Y")
Lun$Answer.Date=as.Date(Lun$Answer.Date, format="%m/%d/%Y")
Lun$Date.Of.Change=as.Date(Lun$Date.Of.Change, format="%m/%d/%Y")
Lun$Verify.Date=as.Date(Lun$Verify.Date, format="%m/%d/%Y")

# Dates from thesis
start_date=as.Date("12/10/2007", format="%d/%m/%Y")
end_date=as.Date("30/09/2010", format="%d/%m/%Y")

L2007=subset(Lun, Report.Date >= start_date)
closed=subset(L2007, Open.Closed == "CLOSED")
closed=closed[order(closed$Verify.Date), ]

plot(L2007$Report.Date-start_date, 1:nrow(L2007), type="l", col=pal_col[1],
	xaxs="i", yaxs="i",
	xlab="Days", ylab="Issues\n")
lines(closed$Verify.Date-start_date, 1:nrow(closed), col=pal_col[2])

legend(x="topleft", legend=c("Reported", "Closed"), bty="n", fill=pal_col, cex=1.2)

# library("changepoint")
# 
# reported=table(L2007$Report.Date)
# cr=cpt.mean(as.vector(reported))
# change_report=cpt.mean(as.numeric(L2007$Report.Date-start_date))
# 
# verify=table(closed$Verify.Date)
# cv=cpt.mean(as.vector(verify))
# verify[150:160]
# 
# change_verify=cpt.mean(as.numeric(closed$Verify.Date-start_date))

P1=subset(L2007, Report.Date-start_date < 400)
P1$is_censored=is.na(P1$Verify.Date) | !(P1$Verify.Date-start_date < 400)
P1$time_taken=ifelse(P1$is_censored, 400-(P1$Report.Date-start_date+1),
					P1$Verify.Date-P1$Report.Date+1)

km1=survfit(Surv(P1$time_taken, !P1$is_censored) ~ 1)
# plot(km1, col=pal_col[1],
# 	xlim=c(1, 1000))
# 
# P2=subset(L2007, (is.na(Verify.Date) | Verify.Date-start_date >= 400) &
# 						Report.Date-start_date < 800)
# P2$is_censored=is.na(P2$Verify.Date) | !(P2$Verify.Date-start_date < 800)
# P2$time_taken=ifelse(P2$is_censored, 800-(P2$Report.Date-start_date+1),
# 					P2$Verify.Date-P2$Report.Date+1)
# 
# km2=survfit(Surv(P2$time_taken, !P2$is_censored) ~ 1)
# lines(km2, col=pal_col[2])
# 
# 
# P3=subset(L2007, is.na(Verify.Date) | Verify.Date-start_date >= 800)
# P3$is_censored=is.na(P3$Verify.Date)
# P3$time_taken=ifelse(P3$is_censored, end_date-P3$Report.Date+1,
# 					P3$Verify.Date-P3$Report.Date+1)
# 
# km3=survfit(Surv(P3$time_taken, !P3$is_censored) ~ 1)
# lines(km3, col=pal_col[3])
# 

plot(km1, col=pal_col[1],
	xlab="Days", ylab="Survival")

P2=subset(L2007, Report.Date-start_date >= 400 & Report.Date-start_date < 800)
P2$is_censored=is.na(P2$Verify.Date) | !(P2$Verify.Date-start_date < 800)
P2$time_taken=ifelse(P2$is_censored, 800-(P2$Report.Date-start_date+1),
					P2$Verify.Date-P2$Report.Date+1)

km2=survfit(Surv(P2$time_taken, !P2$is_censored) ~ 1)
lines(km2, col=pal_col[2])


P3=subset(L2007, Report.Date-start_date >= 800)
P3$is_censored=is.na(P3$Verify.Date)
P3$time_taken=ifelse(P3$is_censored, end_date-P3$Report.Date,
					P3$Verify.Date-P3$Report.Date+1)

km3=survfit(Surv(P3$time_taken, !P3$is_censored) ~ 1)
lines(km3, col=pal_col[3])

legend(x="bottomleft", legend=c("Reported < 400 days", "400 days < Reported < 800 days", "800 days < Reported"), bty="n", fill=pal_col, cex=1.2)

