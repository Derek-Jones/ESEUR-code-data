#
# feat-bug-corr-7dig.R, 23 Aug 12
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

plot_layout(2, 1)
par(mai=c(1, 0.8, 0.0, 0.1))

p=read.csv(paste0(ESEUR_dir, "projects/agile-work/7digital2012.csv.xz"))

# Bracket the data start/end dates
base.date="20/04/2009"  # a Monday
base.day=as.integer(as.Date(base.date, "%d/%m/%Y"))
end.day=as.integer(as.Date("01/08/2012", "%d/%m/%Y"))-base.day


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


# For each day return the total number of work-days for each
# feature that has reached a Done 'state'
feature.work.increment=function(done.list)
{
done.num=as.integer(as.Date(done.list$Done, format="%d/%m/%Y"))-base.day
dl=rep(0, end.day)

sum.done=function(done.day)
   {
   dl[done.day] <<- dl[done.day]+sum(done.list$Cycle.Time[done.num == done.day])
   }

t=sapply(1:end.day, function(x) sum.done(x))

return(dl)
}


# Calculate weekend days so they can be removed from totals.
# base.day is a Monday, so first Saturday starts at day 5
weekends=c(seq(5, end.day ,by=7), # Saturday
           seq(6, end.day, by=7))
hol.days=as.vector(get.ph.days())-base.day
hol.days=hol.days[hol.days > 0 & !is.na(hol.days)]


# Plot cross-correlation between bugs and non-bugs
#all.bug.prio=sum.starts(p[p$Type == "Production Bug", ]$Done)
all.bug.prio=sum.starts(p[grep(".*Bug$", p$Type), ]$Prioritised)
all.bug.prio=all.bug.prio[-weekends]
all.bug.prio=all.bug.prio[-hol.days]
all.bug.prio=rollmean(all.bug.prio, 3)
all.features=feature.work.increment(p)
all.features=all.features[-weekends]
all.features=all.features[-hol.days]
all.features=rollmean(all.features, 3)
non.bug.done=feature.work.increment(p[-grep(".*Bug$", p$Type), ])
#non.bug.done=sum.starts(p[-grep(".*Bug$", p$Type), ]$Done)
#non.bug.done=sum.starts(p[p$Type == "MMF", ]$Done)
non.bug.done=non.bug.done[-weekends]
non.bug.done=non.bug.done[-hol.days]
non.bug.done=rollmean(non.bug.done, 3)
# Many bugs reported at start will be caused by feature implementations
# that were Done before the start of recording.  Ignore the
# first 100 workdays so we are probably only checking for a correlation
# where one might exist
ccf(non.bug.done[-(1:100)], all.bug.prio[-(1:100)], lag.max=150,
        xlab="Work days (nonbug features)", ylab="Cross correlation",
        main="")
ccf(all.features[-(1:100)], all.bug.prio[-(1:100)], lag.max=150,
        xlab="Work days (all features)", ylab="Cross correlation",
        main="")


