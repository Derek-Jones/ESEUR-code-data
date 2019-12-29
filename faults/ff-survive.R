#
# ff-survive.R, 21 Nov 19
#
# Uses data from:
# After-Life Vulnerabilities: A Study on Firefox Evolution, its Vulnerabilities, and Fixes
# Fabio Massacci and Stephen Neuhaud and Viet Hung Nguyen
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG firefox vulnerability_survival


source("ESEUR_config.r")

library(plyr)
library(survival)


study_start=as.Date("9-November-2004", format="%d-%B-%Y")
study_end=as.Date("1-October-2010", format="%d-%B-%Y")

# Interval used to calculate and plot data
every_day=seq(study_start, study_end, by=1)

# version,v1.0,v1.5,v2.0,v3.0,v3.5,v3.6
# Treat column 1 as the rownames
version_fault=read.csv(paste0(ESEUR_dir, "faults/ff-version-fault.csv.xz"), row.names=1, as.is=TRUE)
vf_names=colnames(version_fault)

# version,release,retire
# date format: 9-November-2004
# Treat column 1 as the rownames
version_dates=read.csv(paste0(ESEUR_dir, "faults/ff-release-retire.csv.xz"), row.names=1, as.is=TRUE)
version_dates$release=as.Date(version_dates$release, format="%d-%B-%Y")
version_dates$retire=as.Date(version_dates$retire, format="%d-%B-%Y")
version_dates$retire[version_dates$retire > study_end]=study_end


mk_censored_release=function(censor_count, src_cluster)
{
if (censor_count == 0)
   return(NULL)

# When the source started being used and when it stopped being used
rep_cluster=names(censor_count)
src_start=version_dates[src_cluster, 1]
rep_start=version_dates[rep_cluster, 1]

#print(c(src_start, rep_start))

# There is no reported data for unreported faults!
survive_list=data.frame(rep_date=rep(NA, censor_count))
survive_list$end=as.numeric(rep_start-study_start)
# start offset is start of version where source was created
survive_list$start=as.numeric(src_start-study_start)
survive_list$src_id=src_cluster
survive_list$rep_id=rep_cluster
survive_list$event=0

return(survive_list)
}


mk_censored_faults=function(fault_count, src_cluster, rep_cluster)
{
if (src_cluster == rep_cluster)
   return(NULL)

start_col= 1+which(names(src_percent) == src_cluster)
end_col= which(names(src_percent) == rep_cluster)
# We want all the percentages missing
percent_missing=as.numeric(1-src_percent[src_cluster, start_col:end_col])

# Latest version
latest_missing=percent_missing[length(percent_missing)]
if (latest_missing == 0)
   return(NULL)
# Number of undetected faults that are assumed to exist in the deleted code
total_cendored=fault_count/latest_missing

# Assign undetected faults to versions whose release censored them
faults_censored=cummax(total_cendored*(percent_missing/latest_missing))
# Put a zero on the front to get a diff for all versions
ver_cen_fault=round(diff(c(0, faults_censored)))
names(ver_cen_fault)=names(src_percent)[start_col:end_col]

# Now build a row for each censored fault

t=adply(ver_cen_fault, 1,
		function(X)
		 mk_censored_release(X, src_cluster))

return(t)
}


# t=mk_censored_faults(10, "v1.0", "v3.0")


# Return dataframe of fault_count rows, each row containing a fault event.
# Gets passed a single cell having an array type
mk_cell_survive=function(fault_count)
{
if (is.na(fault_count))
   return(NULL)

# Use names of row/column to index into version/date array
src_cluster=rownames(fault_count)
rep_cluster=colnames(fault_count)
src_start_date=version_dates[src_cluster, 1]
rep_start_date=version_dates[rep_cluster, 1]
rep_end_date=version_dates[rep_cluster, 2]

# convert from array
cur_fault_count=as.integer(fault_count)

# print(fault_count)

if (cur_fault_count == 0)
   {
   return(NULL)
   }

censored_faults=mk_censored_faults(cur_fault_count, src_cluster, rep_cluster)
censored_faults$X1=NULL

# Calculate  time interval information
start_offset=as.numeric(rep_start_date)
end_offset=as.numeric(rep_end_date)
v_interval=end_offset-start_offset
f_width=v_interval / cur_fault_count

# print(c(start_offset, end_offset, v_interval, f_width))

# end offset is from start of report period
# Assume uniform time spacing between faults
survive_list=data.frame(rep_date=rep_start_date+runif(cur_fault_count, 1, v_interval))
survive_list=data.frame(rep_date=rep_start_date+(1:cur_fault_count)*f_width)
# Randomise the fault time
# survive_list$end=as.numeric(survive_list$rep_date-study_start)
# start offset is start of version where source was created
survive_list$start=as.numeric(src_start_date-study_start)
survive_list$src_id=src_cluster
survive_list$rep_id=rep_cluster
survive_list$event=1

#print(head(censored_faults))
#print(head(survive_list))

return(rbind(survive_list, censored_faults))
}


# Take a row and iterate over each cell (column)
mk_row_survive=function(version_row)
{
t=adply(version_row, 2, mk_cell_survive)

return(t)
}


# Take an array and iterate over each row
mk_survive=function(version_array)
{
t=adply(version_array, 1, mk_row_survive)

return(t)
}


# Take the original data format and convert to the one used here.
# Convert a list of values into a 2-D matrix
#
# src_version=read.csv(paste0(ESEUR_dir, "faults/orig-ff-src-version.csv.xz"), as.is=TRUE)
# 
# q=matrix(data=0, nrow=6, ncol=6)
# rownames(q)=c("v1.0", "v1.5", "v2.0", "v3.0", "v3.5", "v3.6")
# colnames(q)=c("v1.0", "v1.5", "v2.0", "v3.0", "v3.5", "v3.6")
# 
# q[cbind(src_version[, 2], src_version[, 1])] = src_version[, 3]
# write.csv(q, file="ff-src-version.csv.xz")

src_LOC=read.csv(paste0(ESEUR_dir, "faults/ff-src-version.csv.xz"), row.names=1, as.is=TRUE)
LOC_diag=diag(src_LOC)

src_percent=src_LOC/diag(as.matrix(src_LOC))

ff_faults=mk_survive(version_fault)
ff_faults$fault_id=1:nrow(ff_faults)
# ff_faults$end=ff_faults$end+runif(nrow(ff_faults), -3, 3)

ff_faults$v1.0=NULL
ff_faults$v1.5=NULL
ff_faults$v2.0=NULL
ff_faults$v3.0=NULL
ff_faults$v3.5=NULL
ff_faults$v3.6=NULL
ff_faults$X1=NULL

# Calculate, for each fault, total number of users over its lifetime
total_usage=function(one_fault)
{
total_usage=sum(daily_ff_usage[(one_fault$start+1):one_fault$end])

return(data.frame(total_usage))
}


browser_ms=read.csv(paste0(ESEUR_dir, "faults/w3stats_browser.csv.xz"), as.is=TRUE)
browser_ms$date=as.Date(browser_ms$date, format="%m/%d/%Y")
# plot(browser_ms$market_share[browser_ms$browser == "v1.0"])

# Get total Firefox market share
total_ff_ms=ddply(browser_ms, .(date),
			function(df) data.frame(ms=sum(df$market_share)))
total_ff_ms$date=as.numeric(total_ff_ms$date)

# Estimate daily market share using a loess model, big fluctuations exist
l_mod=loess(ms ~ date, data=total_ff_ms, span=0.2)
daily_ff_ms=predict(l_mod, newdata=data.frame(date=as.numeric(every_day)))


# Estimate the number of Internet users on every day of the study period
# ITU gives figures per 100 head of population
i_users=read.csv(paste0(ESEUR_dir, "faults/itu-internet-users.csv.xz"), as.is=TRUE)
i_users$year=as.Date(i_users$year)
user_mod=lm(Developed ~ year, data=i_users)
daily_i_users=predict(user_mod, newdata=data.frame(year=every_day))
# Assume 9% population growth per year
pop_growth=(1.09^(1/365))^(1:length(daily_i_users))
daily_i_users=daily_i_users*pop_growth

daily_ff_usage=daily_ff_ms*daily_i_users

# Split start/end duration of fault into weekly chunks
split_start_end=function(one_fault)
{
t=seq(one_fault$start, one_fault$end, by = 7)
# Make sure there is room on the end for an 'event'
split_start=t[t < one_fault$end-7]

# Do we need to split the time interval?
if (one_fault$end-7 < one_fault$start)
   {
   f_interval=one_fault
   }
else
   {
# Copy the row for each interval
   f_interval=one_fault[rep(1, length(split_start)), ]
   f_interval$start=split_start
   f_interval$end=split_start+7
   f_interval$event=0
   t=one_fault
   t$start=f_interval$end[nrow(f_interval)]
   f_interval=rbind(f_interval, t)
   }

t=adply(f_interval, 1, total_usage)
return(t)
}

#sf_faults=ff_faults[order(ff_faults$start), ]
#ff_usage=adply(sf_faults, 1, split_start_end)


ff_usage=adply(ff_faults, 1, split_start_end)

# plot(ff_usage$total_usage, ff_usage$end-ff_usage$start)
# plot(ff_usage$end-ff_usage$start, ff_usage$total_usage)
# t=subset(ff_usage, event == 0)
# plot(t$total_usage, t$end-t$start)

#f_sur=Surv(ff_usage$end-ff_usage$start, event=ff_usage$event, type="right")
f_sur=Surv(time=ff_usage$start, time2=ff_usage$end, event=ff_usage$event)

f_fit=survfit(f_sur ~ 1+cluster(ff_usage$fault_id))
plot(f_fit)


# plot_KM=function(ver_str)
# {
# t=subset(ff_usage, src_id == ver_str)
# f_sur=Surv(t$end-t$start, event=t$event, type="right")
# 
# f_fit=survfit(f_sur ~ 1)
# plot(f_fit, xlim=c(0, 2200))
# }
# 
# plot_KM("v1.0")
# par(new=TRUE)
# plot_KM("v1.5")
# par(new=TRUE)
# plot_KM("v2.0")
# par(new=TRUE)
# plot_KM("v3.0")



#ff_cox=coxph(f_sur ~ total_usage+fractor(src_id)+cluster(fault_id), data=ff_usage)
ff_cox=coxph(f_sur ~ total_usage+strata(src_id)+cluster(fault_id), data=ff_usage)

t=cox.zph(ff_cox)
t
plot(t)


ff_cox=coxph(Surv(time=start, time2=end, event=event) ~
                total_usage+strata(src_id)+cluster(fault_id), data=ff_usage)

v1=subset(ff_usage, src_id == "v1.0")
v_sur=Surv(v1$start, v1$end, v1$event)
ff_cox=coxph(v_sur ~ total_usage, data=v1, ties="breslow")

v1=ff_usage[1:100, ]
#v1=ff_usage
v_sur=Surv(time=v1$start, time2=v1$end, event=v1$event)
ff_cox=coxph(v_sur ~ total_usage+cluster(fault_id), data=v1)


library(rms)

f_sur=Srv(time=ff_usage$start, time2=ff_usage$end, event=ff_usage$event)
ff_cox=cph(f_sur ~ total_usage+strat(src_id)+cluster(fault_id), data=ff_usage)


