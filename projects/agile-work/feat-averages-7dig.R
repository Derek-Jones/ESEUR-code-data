#
# feat-averages-7dig.R, 22 Feb 16
#
# Various analysis of http://www.7digital.com feature data
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

plot_wide()
pal_col=rainbow(2)

source(paste0(ESEUR_dir, "projects/agile-work/feat-common-7dig.R"))


# What is the Cycle.Time moving average?

cma=data.frame(Cycle.Time=p$Cycle.Time,
               Done=as.integer(p$Done)-base_day)


# Return the mean of all cyle times that occur between two dates.
# Need to handle weekend days that occur between dates to get accurate
# answer, but broad brush good enough for now.
cycle_ma_between=function(start_day, num_days)
{
return(mean(subset(cma, Done >= (start_day-num_days+1) &
                           Done <= start_day)$Cycle.Time))
}


#cma_10=sapply(1:end_day, function(x) cycle_ma_between(x, 10))
#cma_20=sapply(1:end_day, function(x) cycle_ma_between(x, 20))
cma_30=sapply(1:end_day, function(x) cycle_ma_between(x, 30))

plot(cma_30, xlim=c(0,1210), col=pal_col[1],
             axes=FALSE, xlab="", ylab="")
axis(1)
mtext("Days since April 2009", side=1, las=0, line=2)
axis(2, col=pal_col[1])
mtext("Feature implementation time", side=2, las=0, line=2)

work_starts=sum_starts(p$Dev.Started)
work_starts=rollmean(work_starts, 30)

points(work_starts, col=pal_col[2])

axis(4, col=pal_col[2])
mtext("Features started", side=4, las=0, line=-1)


