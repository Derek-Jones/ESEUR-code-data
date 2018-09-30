#
# linux-amr-pairs.R, 23 Sep 18
#
# Data from:
# Linux Kernel history
# Greg Kroah-Hartman
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Linux LOC evolution


source("ESEUR_config.r")


pal_col=rainbow(2)

# version,date released,days,commits,number files,number lines,lines added,lines removed,lines modified,number developers,number employers,changes per day,changes per hour,perc growth files,perc growth lines,lines added per day,lines removed per day,lines changed per day,lines added per hour
amr=read.csv(paste0(ESEUR_dir, "regression/kernel_stats.csv.xz"), as.is=TRUE)

# Exclude two outliers
amr_no_out=subset(amr, lines.added < 1500000)

pairs(~ lines.added+lines.removed+lines.modified+I(lines.added-lines.removed)+number.files+number.lines,
			labels=c("added", "removed", "modified", "growth", "files", "total lines"),
			col=pal_col[2],
			cex.labels=1.1, cex.axis=1.0,
			data=amr_no_out, panel = panel.smooth)

# Plot by lines per day
# pairs(~ I(lines.added/days)+I(lines.removed/days)+I(lines.modified/days)+I((lines.added-lines.removed)/days)+number.files+number.lines,
# 			labels=c("added", "removed", "modified", "growth", "files", "total lines"),
# 			col=pal_col[1],
# 			cex.labels=1.2, cex.axis=1.1,
# 			data=amr, panel = panel.smooth)

