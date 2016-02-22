#
# feat-bug-corr-7dig.R, 14 Feb 16
#
# Various analysis of http://www.7digital.com feature data
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

plot_layout(2, 1)
par(mai=c(1, 0.8, 0.0, 0.1))

source(paste0(ESEUR_dir, "projects/agile-work/feat-common-7dig.R"))


# For each day return the total number of work-days for each
# feature that has reached a Done 'state'
feature_work_increment=function(done_list)
{
done_num=as.integer(done_list$Done)-base_day
dl=rep(0, end_day)

sum_done=function(done_day)
   {
   dl[done_day] <<- dl[done_day]+sum(done_list$Cycle.Time[done_num == done_day])
   }

dummy=sapply(1:end_day, function(x) sum_done(x))

return(dl)
}


hol_days=as.vector(get_ph_days())-base_day
hol_days=hol_days[hol_days > 0 & !is.na(hol_days)]


# Plot cross-correlation between bugs and non-bugs
#all_bug_prio=sum_starts(subset(p, Type == "Production Bug")$Done)
all_bug_prio=sum_starts(subset(p, grepl(".*Bug$", p$Type))$Prioritised)
all_bug_prio=all_bug_prio[-weekends]
all_bug_prio=all_bug_prio[-hol_days]
all_bug_prio=rollmean(all_bug_prio, 3)
all_features=feature_work_increment(p)
all_features=all_features[-weekends]
all_features=all_features[-hol_days]
all_features=rollmean(all_features, 3)
non_bug_done=feature_work_increment(subset(p, !grepl(".*Bug$", p$Type)))
#non_bug_done=sum_starts(subset(p, !grepl(".*Bug$", p$Type))$Done)
#non_bug_done=sum_starts(subset(p, Type == "MMF")$Done)
non_bug_done=non_bug_done[-weekends]
non_bug_done=non_bug_done[-hol_days]
non_bug_done=rollmean(non_bug_done, 3)
# Many bugs reported at start will be caused by feature implementations
# that were Done before the start of recording.  Ignore the
# first 100 workdays so we are probably only checking for a correlation
# where one might exist
ccf(non_bug_done[-(1:100)], all_bug_prio[-(1:100)], lag.max=150,
        xlab="Work days (nonbug features)", ylab="Cross correlation",
        main="")
ccf(all_features[-(1:100)], all_bug_prio[-(1:100)], lag.max=150,
        xlab="Work days (all features)", ylab="Cross correlation",
        main="")


