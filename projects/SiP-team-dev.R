#
# SiP-team-dev.R, 16 Oct 19
# Data from:
# A conversation around the analysis of the {SiP} effort estimation dataset
# Derek M. Jones and Stephen Cullum
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Agile tasks duration_days company

source("ESEUR_config.r")


library("plyr")


Sip_all=read.csv(paste0(ESEUR_dir, "projects/Sip-task-info.csv.xz"), as.is=TRUE)

# Removed the 190 tasks that were cancelled before completion
Sip=subset(Sip_all, StatusCode != "CANCELLED")
# Single instance of this in the data
Sip=subset(Sip, StatusCode != "TEMPLATE")
# Projects that were not completed at the time of the data snapshot
Sip=subset(Sip, StatusCode != "CHRONICLE")

devs=count(Sip$DeveloperID)
plot(sort(devs$freq, decreasing=TRUE), type="b", log="y", col=point_col,
        xlab="Developers", ylab="Tasks\n")


