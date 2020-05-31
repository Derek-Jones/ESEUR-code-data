#
# 847d0b-xeon.R, 16 May 20
# Data from:
# Performance Awareness in Agile Software Development
# Vojt\v{e}ch Hork\'{y}
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_software testing_performance

source("ESEUR_config.r")


library("vioplot")


spl=read.csv(paste0(ESEUR_dir, "projects/847d0b-xeon.csv.xz"), as.is=TRUE)

# length(unique(spl$commit))
pal_col=rainbow(length(unique(spl$commit)))

vioplot(msec/1000 ~ commit, data=spl, log="y", xaxt="n",
        col=pal_col, colMed="red", border=pal_col,
	xaxs="i",
	xlab="Commit", ylab="Time (seconds)\n")


