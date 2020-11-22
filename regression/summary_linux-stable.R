#
# summary_linux-stable.R,  8 Jan 14
#
# Data from:
# Linux Kernel development: How fast it is going, who is doing it, what they are doing, and who is sponsoring it (Mar 2012)
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Linux_updates LOC_evolution developer Linux_2012

source("ESEUR_config.r")

patches=read.csv(paste0(ESEUR_dir, "regression/linux-patch-fix.csv.xz"), as.is=TRUE)

cleaned=subset(patches, Total.Updates < 40)

c_mod=glm(Fixes ~ Total.Updates, data=cleaned)

print(summary(c_mod))

