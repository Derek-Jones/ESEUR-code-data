#
# feat-inprog-lagplot-7dig.R, 30 Dec 15
#
# Data from:
# http://www.7digital.com feature data
#
# R code for book "Empirical Software Engineering using R"
# Derek M. Jones, http://shape-of-code.coding-guidelines.com
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

p=read.csv(paste0(ESEUR_dir, "projects/7digital2012.csv.xz"), as.is=TRUE)

# Bracket the data start/end dates
base.date="20/04/2009"  # a Monday
base.day=as.integer(as.Date(base.date, "%d/%m/%Y"))
end.day=as.integer(as.Date("01/08/2012", "%d/%m/%Y"))-base.day


# What is the Cycle.Time moving average?


# Look at number of features currently in progress on any day
#
sum.day.range=function(start.list, end.list, max.days=300)
{
day.totals=rep(0, end.day)

sum.one.feature=function(start.date, end.date)
   {
# Range of days over which this project is active
   t=as.integer(as.Date(start.date, format="%d/%m/%Y", origin=base.date):
             as.Date(end.date, format="%d/%m/%Y", origin=base.date)) - base.day

# Need to adjust for weekends!!!
   # No feature can take longer than max.days to implement
   if (length(t) > max.days)
      return(0)

   # Update variable in outer scope!
   day.totals[t] <<- day.totals[t]+1
   return(0)
   }
dummy=lapply(1:length(start.list),
                      function(x) sum.one.feature(start.list[x], end.list[x]))

return(day.totals)
}


# Return the day number of public holidays in England and Wales
get.ph.days=function()
{
ew.hols=read.csv(paste0(ESEUR_dir, "projects//england-wales-hols.csv.xz"), as.is=TRUE)

return(sapply(1:ncol(ew.hols), function(x)
               as.integer(as.Date(as.character(ew.hols[,x]), format="%d %b %Y"))))
}


# Return the number of events happening on each date in date.list
sum.starts=function(date.list)
{
dl=rep(0, end.day)
t=table(as.integer(as.Date(date.list, format="%d/%m/%Y"))-base.day)
dl[as.integer(dimnames(t)[[1]])]=as.vector(t)

return(dl)
}


# Calculate weekend days so they can be removed from totals.
# base.day is a Monday, so first Saturday starts at day 5
weekends=c(seq(5, end.day ,by=7), # Saturday
           seq(6, end.day, by=7))


par(las=1)
par(col="black")
par(bty="l")

# Autocorrelation of in-progress features
day.totals=sum.day.range(p$Dev.Started, p$Done, 3)
weekday.totals=day.totals[-weekends]

hol.days=as.vector(get.ph.days())-base.day
hol.days=hol.days[hol.days > 0 & !is.na(hol.days)]
workday.totals=weekday.totals[-hol.days]

trend=lm(w180.totals ~ time(w180.totals))
workday.detrend=w180.totals-predict(trend)

lag.plot(workday.detrend, lag=9, diag=FALSE)


