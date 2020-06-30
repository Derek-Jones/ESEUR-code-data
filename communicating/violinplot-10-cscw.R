#
# violinplot-10-cscw.R, 12 Apr 20
#
# Data from:
# Information Needs in Bug Reports: Improving Cooperation Between Developers and Users
# Silvia Breu and Rahul Premraj and Jonathan Sillito and Thomas Zimmermann
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG fault-report

source("ESEUR_config.r")


library("vioplot")


plot_layout(1, 1, default_height=5)
par(mar=MAR_default-c(0.7, 0.0, 0.9, 0))


bug_rep=read.csv(paste0(ESEUR_dir, "communicating/10-cscw-data.csv.xz"), as.is=TRUE)

eclipse_rep=subset(bug_rep, project == "Eclipse")
# vioplot cannot handle NA
eclipse_rep=subset(eclipse_rep, !is.na(min.response.time))
eclipse_rep=subset(eclipse_rep, min.response.time > 0)


vioplot(log(eclipse_rep$min.response.time),
	col="yellow", colMed="red",
	# lineCol="green", rectCol="pink",
	xaxp=c(0.5, 1.5, 15), xaxt="n",
	ylim=range(log(eclipse_rep$min.response.time)),
	xlab="", ylab="log(Seconds)\n")


# library("beanplot")
# 
# beanplot(eclipse_rep$min.response.time, col="yellow", log="y",
# 		what=c(1, 1, 0, 0),
# 		ylab="Seconds")

# Not a lot to see, rather limited functionality, move along.
# More for including a simple violin plot in something complicated.
# bwplot(log(eclipse_rep$min.response.time),
# 	panel=panel.violin, col="yellow",
# 		xlab="log(seconds)")
#

