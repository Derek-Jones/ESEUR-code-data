#
# circle-bin.R,  1 Jun 16
#
# Data from:
# Do time of day and developer experience affect commit bugginess?
# Jon Eyolfson and Lin Tan and Patrick Lam
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG commit faults time-of-day

source("ESEUR_config.r")

library("circular")


plot_layout(2, 1)

pal_col=rainbow(3)

# id repository_id raw_author_id sha1 merge utc_time local_time
commits=read.csv(paste0(ESEUR_dir, "time-series/commits/scc_commit.tsv.xz"), sep="\t", as.is=TRUE)

commits$sha1=NULL

# 2011-09-09 11:30:27
commits$local_time=as.POSIXct(commits$local_time, format="%Y-%m-%d %H:%M:%S")

days_per_week=7
hrs_per_day=24
hrs_per_week=hrs_per_day*days_per_week
mins_per_week=60*hrs_per_day*days_per_week
day_angle=seq(0, 359, 360/days_per_week)

# 1-Jan-1970 is a Thursday
shift_days=3
shift_hrs=shift_days*hrs_per_day
shift_mins=shift_days*60*hrs_per_day

# Bin the data by minute, hour and day.
# Then calculate the mean for each granularity of bin size
bin_means=function(df)
{
mins=as.numeric(round(df$local_time, units="mins")) / (60)
week_mins=(shift_mins+mins) %% mins_per_week
hrs=as.numeric(round(df$local_time, units="hours")) / (60*60)
week_hr=(shift_hrs+hrs) %% hrs_per_week
days=as.numeric(round(df$local_time, units="days")) / (60*60*24)
week_days=(shift_days+days) %% days_per_week

# Map to a 360 degree circle
DoW=circular((360/days_per_week)*week_days, units="degrees", rotation="clock")
HoW=circular((360/hrs_per_week)*week_hr, units="degrees", rotation="clock")
MoW=circular((360/mins_per_week)*week_mins, units="degrees", rotation="clock")

# Mean values for minute, hour, and day measurement granularity.
print(c(mean(DoW)[[1]], rho.circular(DoW)))
print(c(mean(HoW)[[1]], rho.circular(HoW)))
print(c(mean(MoW)[[1]], rho.circular(MoW)))

return(HoW)
}


# Linux
linux_circ=bin_means(subset(commits, repository_id == 1))
# FreeBSD
BSD_circ=bin_means(subset(commits, repository_id == 5))

