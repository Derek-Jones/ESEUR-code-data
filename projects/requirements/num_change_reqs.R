#
# num_change_reqs.R, 23 Oct 17
#
# Data from:
# Observational Models of Requirements Evolution
# Massimo Felici
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG requirements_evolution

source("ESEUR_config.r")


# plot_layout(2, 1)

# Values extracted using WebPlotDigitizer.
req_changes=read.csv(paste0(ESEUR_dir, "projects/requirements/num_change_reqs.csv.xz"), as.is=TRUE)
req_changes=trunc(req_changes*100+0.5)

perc_changes=read.csv(paste0(ESEUR_dir, "projects/requirements/all_F1-8.csv.xz"), as.is=TRUE)

evol_reqs=read.csv(paste0(ESEUR_dir, "projects/requirements/evol-reqs.csv.xz"), as.is=TRUE)

plot_feature=function(X)
{
frac_changes=perc_changes[ , X]/100
lines(cumsum(frac_changes*req_changes$changes), col=pal_col[X])
}


plot_percent=function(X)
{
frac_changes=perc_changes[ , X]/100
# lines(1:nrow(perc_changes)+0.1*X, perc_changes[ , X], type="h", col=pal_col[X])
lines(perc_changes[ , X], col=pal_col[X])
}


pal_col=rainbow(ncol(perc_changes))

# max_changes=max(colSums(perc_changes*req_changes$changes/100))

# # We only know relative values, so don't list values on y-axis
# plot(0, type="n",
# 	yaxt="n",
# 	xlim=c(1, nrow(req_changes)), ylim=c(1, max_changes),
# 	xlab="Release", ylab="Cumulative requirement changes")
# axis(2, at=seq(0, max_changes, length.out=5), labels=rep("", 5))
# 
# 
# dummy=sapply(1:ncol(perc_changes), plot_feature)


plot(0, type="n",
	yaxs="i",
	xlim=c(1, nrow(req_changes)), ylim=c(0, 100),
	xlab="Release", ylab="Requirements changed (percent)\n")

dummy=sapply(1:ncol(perc_changes), plot_percent)


# 
# total_changes=colSums(perc_changes*req_changes$changes/100)
# 
# req_normalise=total_changes[1]/evol_reqs$total_reqs[1]
# 
# evol_reqs$actual_reqs=evol_reqs$total_reqs*req_normalise
# 
# plot(evol_reqs$actual_reqs, evol_reqs$cum_changes, col=point_col,
# 	xlab="Actual requests", ylab="Actual changes")
# 
