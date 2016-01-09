#
# disk-activity.R,  3 Jun 14
#
# Data from:
# An analysis of storage system activity
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_hist = function(time_diff)
{
bin_width=c(0, exp(log(max(time_diff))/num_bins)^(1:num_bins))
p=hist(time_diff, breaks=bin_width, plot=FALSE)

p$breaks[1]=1e-4 # require a non-zero value in a log-log plot

plot((p$breaks[1:num_bins]*p$breaks[2:(num_bins+1)])^0.5, # geometric mean
      p$density,
      type="b",
      xlim=c(1e1, 1e8), ylim=c(1e-12, 1e-2),
      xlab="Time interval (microseconds)", ylab="Density", log="xy")

}

rd=read.csv(paste0(ESEUR_dir, "hardware/disk-activity/read.diff"), as.is=TRUE)
pd=rd$time_gap

num_bins=50

plot_hist(pd)

# Less regular when using small, fixed width, bins...
t=table(pd)
plot(log(t), log="x")


plot(density(log(pd)), log="xy")

