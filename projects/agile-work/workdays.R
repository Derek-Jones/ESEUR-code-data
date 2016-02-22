#
# workdays.R, 14 Feb 16
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones



# Shift a Saturday day to Friday and Sunday to Monday
fix_miss_day=function(day_list)
{
day_list[(day_list %% 7) == 5]=day_list[(day_list %% 7) == 5]-1
day_list[(day_list %% 7) == 6]=day_list[(day_list %% 7) == 6]+1

return(day_list)
}


# as.Date counts days since 1 Jan 1970 (which was a Thursday)
# Add 3 makes Monday the Day 0 and Saturday is Day 5
NetWorkDays = function(start_date, end_date)
{
start_day=fix_miss_day(as.numeric(as.Date(start_date, "%d/%m/%Y"))+3)
end_day=fix_miss_day(as.numeric(as.Date(end_date, "%d/%m/%Y"))+3)
days_diff=end_day - start_day

num_weeks=days_diff %/% 7

hol_days=as.vector(get_ph_days())
hol_days=hol_days[hol_days > 0 & !is.na(hol_days)]
start_hols=sapply(1:length(start_day), function(x)
                             length(which(start_day[x] > hol_days)))
end_hols=sapply(1:length(start_day), function(x)
                             length(which(end_day[x] > hol_days)))

days_left=(days_diff %% 7)
day_max=days_left + start_day %% 7

# Does days_left+start_day include any weekend days?
weekend_days=ifelse(day_max > 4, ifelse(day_max > 5, 2, 1), 0)

# Add 1 because we count start==end as 1 day
return(num_weeks*5+days_left+1-weekend_days - (end_hols-start_hols))
}

