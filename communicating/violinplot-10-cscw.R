#
# violinplot-10-cscw.R, 22 Mar 14
#
# Data from:
# Information Needs in Bug Reports: Improving Cooperation Between Developers and Users
# Silvia Breu and Rahul Premraj and Jonathan Sillito and Thomas Zimmermann
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

library("vioplot")

plot_layout(1, 2)


bug_rep=read.csv(paste0(ESEUR_dir, "communicating/10-cscw-data.csv.xz"), as.is=TRUE)

eclipse_rep=subset(bug_rep, project == "Eclipse")
# vioplot cannot handle NA
eclipse_rep=subset(eclipse_rep, !is.na(min.response.time))
eclipse_rep=subset(eclipse_rep, min.response.time > 0)

# vioplot raises error if an attempt is made to specify axis labels.
# Best approach is to use plot to control layout and add=TRUE in vioplot.
# log="y" produces weird results.
plot(x=0.1,
	xlab="", ylab="log(seconds)",
	xaxt="n",
	xlim=c(0.2, 1.8), ylim=range(log(eclipse_rep$min.response.time)))

vioplot(log(eclipse_rep$min.response.time),
	col="yellow", colMed="red",
	wex=1.5,
	add=TRUE)


library("beanplot")

beanplot(eclipse_rep$min.response.time, col="yellow", log="y",
		what=c(1, 1, 0, 0),
		ylab="Seconds\n")

# Not a lot to see, rather limited functionality, move along.
# More for including a simple violin plot in something complicated.
# bwplot(log(eclipse_rep$min.response.time),
# 	panel=panel.violin, col="yellow",
# 		xlab="log(seconds)")


