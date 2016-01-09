#
# feat-inprog-autocor-7dig.R, 17 Aug 12
#
# Various analysis of http://www.7digital.com feature data
#
# R code for book "Empirical Software Engineering using R"
# Derek M. Jones, http://shape-of-code.coding-guidelines.com
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("zoo")


plot_layout(2, 2)

p=read.csv(paste0(ESEUR_dir, "projects/agile-work/7digital2012.csv.xz"))

p$Done=as.Date(p$Done, "%d/%m/%Y")
# Bracket the data start/end dates
base.date="20/04/2009"  # a Monday
base.day=as.integer(as.Date(base.date, "%d/%m/%Y"))
end.day=as.integer(as.Date("01/08/2012", "%d/%m/%Y"))-base.day

# Calculate weekend days so they can be removed from totals.
# base.day is a Monday, so first Saturday starts at day 5
weekends=c(seq(5, end.day ,by=7), # Saturday
           seq(6, end.day, by=7))



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
ew.hols=read.csv(paste0(ESEUR_dir, "projects/agile-work/england-wales-hols.csv.xz"),
                  header=TRUE)

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


# Autocorrelation of in-progress features
day.totals=sum.day.range(p$Dev.Started, p$Done, 3)
weekday.totals=day.totals[-weekends]

day.totals=rollmean(day.totals, 3) # Just to tidy up the first two plots

hol.days=as.vector(get.ph.days())-base.day
hol.days=hol.days[hol.days > 0 & !is.na(hol.days)]
workday.totals=weekday.totals[-hol.days]

trend=glm(day.totals ~ time(day.totals))
plot(day.totals, xlab="Days since Apr 2009", ylab="Features in-progress")
abline(trend, col="pink")
most.day.totals=day.totals[250:length(day.totals)]
trend=glm(most.day.totals ~ time(most.day.totals))
# Adjust intercept because we fitted values offset by 250
abline(a=trend$coef[1]-trend$coef[2]*250, b=trend$coef[2], col="red")
day.detrend=most.day.totals-predict(trend)
as.Date(base.day)+250
plot(day.detrend, xlab="Days since Jan 2010", ylab="In-progress about mean")
w180.totals=workday.totals[-(1:180)] # remove first 180 days
trend=glm(w180.totals ~ time(w180.totals))
workday.detrend=w180.totals-predict(trend)
acf(day.detrend, lag.max=365, xlab="Lag in Days", main="")
acf(workday.detrend, lag.max=250, xlab="Lag in workdays", main="")

