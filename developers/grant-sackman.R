#
# grant-sackman.R,  4 Mar 20
# Data from:
# The 28:1 {Grant}/{Sackman} legend is misleading, or: {How} large is interpersonal variation really?
# Lutz Prechelt
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human developer_performance


source("ESEUR_config.r")


library("vioplot")


pal_col=rainbow(8)

gs=read.csv(paste0(ESEUR_dir, "developers/grant-sackman.csv.xz"), as.is=TRUE)

vioplot(time ~ group+task, data=gs, horizontal=TRUE, col=pal_col,
		xaxs="i",
		ylim=c(0, max(gs$time)),
		xlab="Time (minutes)", ylab="")

# library("plyr")
# 
# daply(gs, .(task), function(df) max(df$time)/min(df$time))
# daply(gs, .(task, group), function(df) max(df$time)/min(df$time))

