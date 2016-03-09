#
# linux-amr-pairs.R,  5 Mar 16
#
# Data from:
# Linux Kernel history
# Greg Kroah-Hartman
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

# version,date released,days,commits,number files,number lines,lines added,lines removed,lines modified,number developers,number employers,changes per day,changes per hour,perc growth files,perc growth lines,lines added per day,lines removed per day,lines changed per day,lines added per hour
adm=read.csv(paste0(ESEUR_dir, "regression/kernel_stats.csv.xz"), as.is=TRUE)

pairs(~ lines.added+lines.removed+lines.modified, col=point_col,
			data=adm, panel = panel.smooth)

