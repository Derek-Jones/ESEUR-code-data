#
# feat-common-7dig.R, 14 Feb 16
#
# Data from:
# http://www.7digital.com feature data
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

library("plyr")
library("zoo")


p=read.csv(paste0(ESEUR_dir, "projects/agile-work/7digital2012.csv.xz"),
			as.is=TRUE)

date_format="%d/%m/%Y"
p$Dev.Started=as.Date(p$Dev.Started, date_format)
p$Done=as.Date(p$Done, date_format)
p$Prioritised=as.Date(p$Prioritised, date_format)
# Bracket the data start/end dates
base_date="20/04/2009"  # a Monday
base_day=as.integer(as.Date(base_date, date_format))
end_day=as.integer(as.Date("01/08/2012", date_format))-base_day

# Calculate weekend days so they can be removed from totals.
# base_day is a Monday, so first Saturday starts at day 5
weekends=c(seq(5, end_day ,by=7), # Saturday
           seq(6, end_day, by=7))


# Count number of features currently in progress on any day
#
sum_day_range=function(start_list, end_list, max_days=300)
{
day_totals=rep(0, end_day)

sum_one_feature=function(start_date, end_date)
   {
# Range of days over which this project is active
   t=as.integer(start_date:end_date) - base_day

# Need to adjust for weekends!!!
   # No feature can take longer than max_days to implement
   if (length(t) > max_days)
      return(0)

   # Update variable in outer scope!
   day_totals[t] <<- day_totals[t]+1
   return(0)
   }
dummy=lapply(1:length(start_list),
                      function(x) sum_one_feature(start_list[x], end_list[x]))

return(day_totals)
}


# Return the day number of public holidays in England and Wales
get_ph_days=function()
{
ew_hols=read.csv(paste0(ESEUR_dir, "projects/agile-work/england-wales-hols.csv.xz"),
                  as.is=TRUE)

return(sapply(1:ncol(ew_hols), function(x)
               as.integer(as.Date(ew_hols[,x], format="%d %b %Y"))))
}


# Return the number of events happening on each date in date_list
sum_starts=function(date_list)
{
dl=rep(0, end_day)
t=count(as.integer(date_list)-base_day)
dl[t$x]=t$freq

return(dl)
}


