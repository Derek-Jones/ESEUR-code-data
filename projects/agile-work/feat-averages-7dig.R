#
# feat-averages-7dig.R, 17 Oct 17
# Data from:
# http://www.7digital.com
# Rob Bowley
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


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
cma_30=sapply(1:end_day, function(x) cycle_ma_between(x, 25))

plot(cma_30, type="l", col=point_col,
	xaxs="i",
	xlab="Days since April 2009", ylab="Feature implementation time")


# library("changepoint")
# 
# 
# change_at=cpt.mean(cma_30[-(1:9)]) # 771 # 641 + 9 NAs
# plot(change_at, col=point_col,
# 	xlab="Days since April 2009", ylab="Feature implementation time")
# 
# change_at=cpt.var(cma_30[-(1:9)]) # 641 + 9 NAs
# plot(change_at, col=point_col,
# 	xlab="Days since April 2009", ylab="Feature implementation time")
# 
