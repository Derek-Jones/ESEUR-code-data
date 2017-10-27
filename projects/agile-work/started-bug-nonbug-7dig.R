#
# started-bug-nonbug-7dig.R, 17 Oct 17
#
# Data from:
# http://www.7digital.com feature data
# Rob Bowley
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

pal_col=rainbow(3)
# plot_layout(3, 1)

source(paste0(ESEUR_dir, "projects/agile-work/feat-common-7dig.R"))


# Bug/Non-bug feature start ratio
plot_two_ratio=function(red_vals, blue_vals)
{
plot(blue_vals, type="l", col=pal_col[1],
	xlim=c(0, 820), ylim=c(0, 7),
	xlab="Work days since Apr 2009", ylab="")
lines(red_vals, col=pal_col[2])
lines(red_vals/blue_vals, col=pal_col[3])
}

all_bugs=sum_starts(subset(p, grepl(".*Bug$", p$Type))$Dev.Started)
all_bugs=all_bugs[-weekends]
non_bugs=sum_starts(subset(p, !grepl(".*Bug$", p$Type))$Dev.Started)
non_bugs=non_bugs[-weekends]


plot_two_ratio(rollmean(all_bugs, 25), rollmean(non_bugs, 25))
# plot_two_ratio(rollmean(all_bugs, 50), rollmean(non_bugs, 50))
# plot_two_ratio(rollmean(all_bugs, 120), rollmean(non_bugs, 120))

legend(x="topleft", legend=c("New features", "Bug fixes", "Bug-fix/New-feature"), bty="n", fill=pal_col, cex=1.2)

