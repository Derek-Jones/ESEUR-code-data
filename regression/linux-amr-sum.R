#
# linux-amr-sum.R, 11 Jun 16
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

# version,date released,days,commits,number files,number lines,lines added,lines removed,lines modified,number developers,number employers,changes per day,changes per hour,perc growth files,perc growth lines,lines added per day,lines removed per day,lines changed per day,lines added per hour
amr=read.csv(paste0(ESEUR_dir, "regression/kernel_stats.csv.xz"), as.is=TRUE)

amr_out=subset(amr, lines.removed < 1e6)

# amr_a_mod=glm(lines.modified ~ lines.added, data=amr_out)
# amr_r_mod=glm(lines.modified ~ lines.removed, data=amr_out)
# amr_r2_mod=glm(lines.modified ~ lines.removed+I(lines.removed^2), data=amr_out)
# amr_ar2_mod=glm(lines.modified ~ lines.added+lines.removed+I(lines.removed^2), data=amr_out)
amr_ar_mod=glm(lines.modified ~ lines.added+lines.removed, data=amr_out)

print(summary(amr_ar_mod, correlation=TRUE))


