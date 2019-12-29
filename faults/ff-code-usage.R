#
# ff_code-usage.R, 21 Nov 19
#
# Data from:
# After-Life Vulnerabilities: A Study on Firefox Evolution, its Vulnerabilities, and Fixes
# Fabio Massacci and Stephen Neuhaud and Viet Hung Nguyen
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG firefox_code-usage code_usage


source("ESEUR_config.r")

library("plyr")


pal_col=rainbow(7)

study_start=as.Date("9-November-2004", format="%d-%B-%Y")
study_end=as.Date("1-October-2010", format="%d-%B-%Y")

# Interval used to calculate and plot data
every_week=seq(study_start, study_end, by=7)

# version,release,retire
# date format: 9-November-2004
# Treat column 1 as the rownames
version_dates=read.csv(paste0(ESEUR_dir, "faults/ff-release-retire.csv.xz"), row.names=1, as.is=TRUE)
version_dates$release=as.Date(version_dates$release, format="%d-%B-%Y")
version_dates$retire=as.Date(version_dates$retire, format="%d-%B-%Y")
version_dates$retire[version_dates$retire > study_end]=study_end

# version,v1.0,v1.5,v2.0,v3.0,v3.5,v3.6
src_version=read.csv(paste0(ESEUR_dir, "faults/ff-src-version.csv.xz"), row.names=1, as.is=TRUE)

# return Firefox version pairs sharing common source code
mk_src_pairs=function(row_version)
{
cn=colnames(src_version)
t=cn[which(src_version[row_version, ] > 0)]
res=data.frame(cbind(row_version, t))
names(res)=c("src_id", "rep_id")

return(res)
}

src_pairs=adply(rownames(src_version), 1, mk_src_pairs)


# Is the oldest version in ver_pair supported during some part of week?
mk_pair_usage=function(ver_pair, week)
{
if ((version_dates[ver_pair$rep_id, 1] <= week) &&
    (week <= version_dates[ver_pair$rep_id, 2]))
   return(cbind(ver_pair, week))
else
   return(NULL)
}


# Get a list of versions supported in any given week
mk_usage=function(a_week)
{
t=adply(src_pairs, 1, function(df) mk_pair_usage(df, a_week))

return(t)
}

usage_list=adply(as.array(every_week), 1, mk_usage)

usage_list$LOC=src_version[cbind(usage_list$src_id, usage_list$rep_id)]


# Return market share of highest version in use when fault reported
get_market_share=function(row)
{
t=subset(browser_ms, browser_ms$browser == row$rep_id)
# Find the market_shared that occured closest to row$week
res=t$market_share[which.min(abs(t$date-row$week))]
return(res)
}


# Browser market share
browser_ms=read.csv(paste0(ESEUR_dir, "faults/w3stats_browser.csv.xz"), as.is=TRUE)
browser_ms$date=as.Date(browser_ms$date, format="%m/%d/%Y")
# plot(browser_ms$market_share[browser_ms$browser == "v1.0"])

# had problems using adply :-(
t=sapply(1:nrow(usage_list), function(X) get_market_share(usage_list[X, ]))
usage_list$market_share=t


# t=ddply(browser_ms, .(date), function(df) sum(df$market_share))
# head(t, n=40)

# Number of people using the internet in each year
i_users=read.csv(paste0(ESEUR_dir, "faults/itu-internet-users.csv.xz"), as.is=TRUE)
i_users$year=as.Date(i_users$year)
# Linear model used to predict internet users during year
user_mod=lm(Developed ~ year, data=i_users)

usage_list$i_users=predict(user_mod, newdata=data.frame(year=usage_list$week))


sum_code_usage=function(df)
{
df$code_usage=sum(df$LOC*df$i_users*df$market_share)

return(df)
}

# Sum usage (for every week) for source originating in version v_str
total_code_usage=function(v_str)
{
t=subset(usage_list, src_id == v_str)
res=ddply(t, .(week), sum_code_usage)

return(res)
}

# Plot total usage for version 1.0 source
t=total_code_usage("v1.0")
xbound=c(min(t$week), max(t$week))
ybound=c(0, max(t$code_usage))

plot(t$week, t$code_usage, type="n",
	yaxs="i",
	xlim=xbound, ylim=ybound,
	xlab="Date", ylab="Amount of end-user code usage\n")

legend(x="topleft", legend=c("All versions", rownames(src_version)), bty="n", fill=pal_col, cex=1.2)


# Plot the usage derived from later version ver_str
plot_version_usage=function(ver_str, ver_col)
{
q=subset(t, rep_id == ver_str)
points(q$week, q$LOC*q$i_users*q$market_share, col=ver_col)
}

# All versions that might contain source originating in v1.0
plot_version_usage("v1.0", pal_col[2])
plot_version_usage("v1.5", pal_col[3])
plot_version_usage("v2.0", pal_col[4])
plot_version_usage("v3.0", pal_col[5])
plot_version_usage("v3.5", pal_col[6])
plot_version_usage("v3.6", pal_col[7])

points(t$week, t$code_usage, col=pal_col[1])

#t=total_version_usage("v2.0")
#plot(t$week, t$LOC*t$i_users*t$market_share,
#	xlab="Date", ylab="Amount of code usage")


