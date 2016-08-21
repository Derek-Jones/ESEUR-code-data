#
# Buettner_T32.R, 17 Feb 16
#
# Data from:
# Designing an Optimal Software Intensive System Acquisition: {A} Game Theoretic Approach
# Douglas John Buettner
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


library("plyr")


brew_col=rainbow(2)

# Project C
bt_c=read.csv(paste0(ESEUR_dir, "time-series/Buettner_T32.csv.xz"), as.is=TRUE)
bt_c=subset(bt_c, !is.na(bt_c$Day))

dt_c=ddply(bt_c, .(Day), function(df) return(nrow(df)))

bc_ts=rep(0, max(bt_c$Day))
bc_ts[dt_c$Day]=dt_c$V1
# Remove the styartup days where no faults reported
bc_ts=bc_ts[min(bt_c$Day):max(bt_c$Day)]

acf(bc_ts, lag.max=100, col=point_col)


