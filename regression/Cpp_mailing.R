#
# Cpp_mailing.R, 12 Oct 20
#
# Data from:
# Extracted from C++ mailing list
# Roger Orr
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG C++_mailing-list extreme-value_emails

source("ESEUR_config.r")


library("circular")
library("extRemes")
library("lubridate")
library("plyr")


# plot_layout(2, 1)


# Get date of email, is workday, its week and month
read_csv=function(f_str)
{
t=read.csv(paste0(ESEUR_dir, "regression/", f_str), as.is=TRUE)

t$date=as.Date(t$date_time, format="%Y-%m-%d")

t$wday=wday(t$date, week_start=1)
t$is_work=(t$wday < 6)
t$week=week(t$date)
t$month=month(t$date)
t$year=year(t$date)

return(t)
}


# Count emails per day
mail_p_day=function(df_date)
{
core_days=count(df_date)

# Some days have no email, so need to add zero entries
min_day=min(df_date)
max_day=max(df_date)
num_days=1+as.integer(max_day-min_day)
all_days=data.frame(date=min_day+0:(num_days-1), freq=rep(0, num_days))

all_days$freq[all_days$date %in% core_days$x]=core_days$freq

all_days$mday=day(all_days$date)
all_days$wday=wday(all_days$date, week_start=1)
all_days$is_work=(all_days$wday < 6)
all_days$week=week(all_days$date)
all_days$month=month(all_days$date)

return(all_days)
}


emails_per_week=function(df)
{
mem=ddply(df, .(year, week), function(df) nrow(df))
mem$total_weeks=mem$year+mem$week

return(mem)
}


max_email_month=function(df)
{
# X1 is the sequence number of the meeting, which is
# enough to make the month number unique.
mem=ddply(df, .(X1, month), function(df) max(df$freq))

return(mem)
}


seasons=function(vec)
{
mon_ts=ts(vec, start=c(0, 0), frequency=12)
plot(stl(mon_ts, s.window="periodic"))

}


# Reverse the order of rows in a dataframe
rev_df=function(df)
{
df_names=names(df)
t=df[nrow(df):1, ]
names(t)=df_names
return(t)
}


# Create a Rose plot
plot_rose=function(weeks)
{
lib_circ=circular(weeks*360/52, units="degrees", template="clock12")

rose.diag(weeks, bins=52, shrink=1.5, prop=6, axes=FALSE, col="blue")
axis.circular(at=circular((0:11)*360/12, units="degrees", rotation="clock"),
			labels=c("Jan", "Feb", "Mar", "Apr", "May", "Jun",
				"Jul", "Aug", "Sep", "Oct", "Nov", "Dec"),
		col="green")
arrows.circular(mean(weeks), y=rho.circular(weeks), col="red", lwd=3)
}


# For every date before a meeting,
# create a date+days_before meeting data frame
mk_days_before=function(last_meeting)
{
days=as.integer(meeting$start[last_meeting+1]-meeting$end[last_meeting])

# Set meeting dates to NA
d_before=rbind(data.frame(date=meeting$start[last_meeting]+(1:6),
				days_before=rep(NA, 6)),
		data.frame(date=meeting$end[last_meeting]+(1:days),
				days_before=days:1)
		)
return(d_before)
}


# Sum of all the emails on weekdays, and sum of all weekend emails
weekly_email=function(df)
{
s_week=which(df$wday == 1)
t_week=adply(s_week, .margin=1, function(X) data.frame(
					freq=c(sum(df$freq[X:(X+4)]),
						sum(df$freq[c(X+5, X+6)])),
					days_before=c(df$days_before[X]-2,
						      df$days_before[X]-5),
					is_work=c(TRUE,FALSE),
					date=df$date[X]
					))

return(t_week)
}


core=read_csv("Cpp_core.txt")
lib=read_csv("Cpp_lib.txt")

core_days=mail_p_day(core$date)
lib_days=mail_p_day(lib$date)

# Is the data stationary?
#
# plot(weeks_before$date, weeks_before$freq)
# 
# weeks_email=emails_per_week(core)
# 
# w_mod=glm(V1 ~ total_weeks, data=weeks_email, family=poisson)
# summary(w_mod)
# 
# > exp(coef(w_mod)[2])^52
# total_weeks 
#    0.8204798  Core
#    1.058093   Lib

# 
# plot_rose(core$week)

# core=lib

# table(core$wday)
# 
# acf(core_days$freq)
# pacf(core_days$freq)

# Dates of WG21 meetings
meeting=read.csv(paste0(ESEUR_dir, "regression/Cpp_meeting-dates.txt"), as.is=TRUE)

# To work out whether volume of emails increases as meetings get closer,
# we need to map date to days before meeting.
meeting$start=as.Date(meeting$start, format="%Y-%m-%d")
meeting$end=meeting$start+5 # meetings run over 6 days
meeting=rev_df(meeting) # does not work for single column dataframe

timeline=adply(1:(nrow(meeting)-1), .margins=1, mk_days_before)

t=merge(timeline, lib_days, by="date")
days_before=subset(t, !is.na(days_before))

weeks_before=weekly_email(days_before)

# plot(t$days_before, t$freq, log="xy")
# 
# x_range=1:200
# 
# loess_mod=loess(log(freq+0.1) ~ log(days_before), span=0.3, data=t)
# loess_pred=predict(loess_mod, newdata=data.frame(days_before=x_range))
# lines(x_range, exp(loess_pred), col="pink")
# 
# dmail_mod=glm(freq ~ log(days_before), data=days_before, family=poisson)
# dmail_mod=glm(freq ~ log(days_before)*is_work, data=days_before, family=poisson)
# summary(dmail_mod)
# 
# wmail_mod=glm(freq ~ log(days_before)*is_work, data=weeks_before, family=poisson)
# summary(wmail_mod)
# 
# table(core_days$freq)

# threshrange.plot(days_before$freq, c(25, 40))
# 
# ext_mod=fevd(days_before$freq, threshold=30, type="GP", period.basis="month")
# 
# plot(ext_mod, rperiods=c(1.1, 3, 6, 12, 18, 24, 36, 72, 120), type="rl", col="red",
# 		main="Core")

# summary(ext_mod)

month_max=max_email_month(days_before)

max_mod=fevd(month_max$V1, type="GEV", period.basis="month")
plot(max_mod, rperiods=c(6, 12, 18, 24, 36, 72, 120), type="rl", col="red",
		main="")

# summary(max_mod)


