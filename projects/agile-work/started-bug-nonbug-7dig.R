#
# started-bug-nonbug-7dig.R, 14 Feb 16
#
# Data from:
#
# http://www.7digital.com feature data
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

pal_col=rainbow(3)
plot_layout(2, 2)

source(paste0(ESEUR_dir, "projects/agile-work/feat-common-7dig.R"))


# Bug/Non-bug feature start ratio
plot_two_ratio=function(red_vals, blue_vals)
{
plot(red_vals, col=pal_col[1],
	xlim=c(0, 820), ylim=c(0, 7),
	xlab="Work Days since Apr 2009", ylab="")
points(blue_vals, col=pal_col[3])
lines(rollmean(blue_vals/red_vals, 40), col=pal_col[2])
}

all_bugs=sum_starts(subset(p, grepl(".*Bug$", p$Type))$Dev.Started)
all_bugs=all_bugs[-weekends]
non_bugs=sum_starts(subset(p, !grepl(".*Bug$", p$Type))$Dev.Started)
non_bugs=non_bugs[-weekends]


plot(all_bugs, col="red",
	xlim=c(0, 820), ylim=c(0, 7),
	xlab="Work Days since Apr 2009", ylab="New feature starts")
#plot(rollmean(all_bugs+non_bugs, 120), xlim=c(0, 820), ylim=c(0, 7),
#          xlab="Work Days", ylab="New feature starts")
plot_two_ratio(rollmean(all_bugs, 20), rollmean(non_bugs, 20))
plot_two_ratio(rollmean(all_bugs, 50), rollmean(non_bugs, 50))
plot_two_ratio(rollmean(all_bugs, 120), rollmean(non_bugs, 120))

