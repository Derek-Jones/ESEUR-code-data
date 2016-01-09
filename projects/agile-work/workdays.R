#
# workdays.R, 27 Aug 12
#
# R code for book "Empirical Software Engineering using R"
# Derek M. Jones, http://shape-of-code.coding-guidelines.com
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


# Return the day number of public holidays in England and Wales
get.ph.days=function()
{
ew.hols=read.csv(paste0(ESEUR_dir, "projects/agile-work/england-wales-hols.csv.xz"),
                  header=TRUE)

return(sapply(1:ncol(ew.hols), function(x)
               as.integer(as.Date(as.character(ew.hols[,x]), format="%d %b %Y"))))
}


# Shift a Saturday day to Friday and Sunday to Monday
fix.miss.day=function(day.list)
{
day.list[(day.list %% 7) == 5]=day.list[(day.list %% 7) == 5]-1
day.list[(day.list %% 7) == 6]=day.list[(day.list %% 7) == 6]+1

return(day.list)
}


# as.Date counts days since 1 Jan 1970 (which was a Thursday)
# Add 3 makes Monday the Day 0 and Saturday is Day 5
NetWorkDays = function(start.date, end.date)
{
start.day=fix.miss.day(as.numeric(as.Date(start.date, "%d/%m/%Y"))+3)
end.day=fix.miss.day(as.numeric(as.Date(end.date, "%d/%m/%Y"))+3)
days.diff=end.day - start.day

num.weeks=days.diff %/% 7

hol.days=as.vector(get.ph.days())
hol.days=hol.days[hol.days > 0 & !is.na(hol.days)]
start.hols=sapply(1:length(start.day), function(x)
                             length(which(start.day[x] > hol.days)))
end.hols=sapply(1:length(start.day), function(x)
                             length(which(end.day[x] > hol.days)))

days.left=(days.diff %% 7)
day.max=days.left + start.day %% 7

# Does days.left+start.day include any weekend days?
weekend.days=ifelse(day.max > 4, ifelse(day.max > 5, 2, 1), 0)

# Add 1 because we count start==end as 1 day
return(num.weeks*5+days.left+1-weekend.days - (end.hols-start.hols))
}

