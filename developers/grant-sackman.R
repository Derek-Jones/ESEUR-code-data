#
# grant-sackman.R, 26 Aug 16
# Data from:
# The 28:1 {Grant}/{Sackman} legend is misleading, or: {How} large is interpersonal variation really?
# Lutz Prechelt
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


brew_col=rainbow_hcl(8)

gs=read.csv(paste0(ESEUR_dir, "developers/grant-sackman.csv.xz"), as.is=TRUE)
gs$task=factor(gs$task)

boxplot(time ~ group+task, data=gs, notch=TRUE, horizontal=TRUE, col=brew_col,
		xlab="Time (minutes)")

# library("plyr")
# 
# daply(gs, .(task), function(df) max(df$time)/min(df$time))
# daply(gs, .(task, group), function(df) max(df$time)/min(df$time))

