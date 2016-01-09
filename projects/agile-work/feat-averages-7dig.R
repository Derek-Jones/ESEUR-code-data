#
# feat-averages-7dig.R, 22 Dec 15
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

pal_col=rainbow(2)

p=read.csv(paste0(ESEUR_dir, "projects/agile-work/7digital2012.csv.xz"))

# Bracket the data start/end dates
base.date="20/04/2009"  # a Monday
base.day=as.integer(as.Date(base.date, "%d/%m/%Y"))
end.day=as.integer(as.Date("01/08/2012", "%d/%m/%Y"))-base.day


# What is the Cycle.Time moving average?

cma=data.frame(Cycle.Time=p$Cycle.Time,
               Done=as.integer(as.Date(p$Done, format="%d/%m/%Y"))-base.day)


# Return the mean of all cyle times that occur between two dates.
# Need to handle weekend days that occur between dates to get accurate
# answer, but broad brush good enough for now.
cycle.ma.between=function(start.day, num.days)
{
return(mean(cma$Cycle.Time[cma$Done >= (start.day-num.days+1) &
                           cma$Done <= start.day]))
}

# Return the number of events happening on each date in date.list
sum.starts=function(date.list)
{
dl=rep(0, end.day)
t=table(as.integer(as.Date(date.list, format="%d/%m/%Y"))-base.day)
dl[as.integer(dimnames(t)[[1]])]=as.vector(t)

return(dl)
}

#cma.10=sapply(1:end.day, function(x) cycle.ma.between(x, 10))
#cma.20=sapply(1:end.day, function(x) cycle.ma.between(x, 20))
cma.30=sapply(1:end.day, function(x) cycle.ma.between(x, 30))

plot(cma.30, xlim=c(0,1210),
          col=pal_col[1],
             axes=FALSE, xlab="", ylab="")
axis(1)
mtext("Days since April 2009", side=1, las=0, line=2)
axis(2, col=pal_col[1])
mtext("Feature implementation time", side=2, las=0, line=2)

work.starts=sum.starts(p$Dev.Start)
work.starts=rollmean(work.starts, 30)

points(work.starts, col=pal_col[2])

axis(4, col=pal_col[2])
mtext("Features started", side=4, las=0, line=-1)


