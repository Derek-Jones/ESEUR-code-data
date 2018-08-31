#
# boxplot-10-cscw.R, 22 Aug 18
#
# Data from:
# Information Needs in Bug Reports: Improving Cooperation Between Developers and Users
# Silvia Breu and Rahul Premraj and Jonathan Sillito and Thomas Zimmermann
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG fault report


source("ESEUR_config.r")


par(bty="n")


bug_rep=read.csv(paste0(ESEUR_dir, "communicating/10-cscw-data.csv.xz"), as.is=TRUE)

eclipse_rep=subset(bug_rep, bug_rep$project == "Eclipse")

box_inf=boxplot(eclipse_rep$min.response.time, log="y",
		boxwex=0.25,
		col="yellow",
		xlim=c(0.9, 2.3),
		ylab="Seconds")

text(1+0.07, box_inf$stats[1, 1], pos=4, "Lower hinge", cex=1.3)
text(1+0.07, box_inf$stats[2, 1], pos=4, "First quartile", cex=1.3)
text(1+0.07, box_inf$stats[3, 1], pos=4, "Median", cex=1.3)
text(1+0.07, box_inf$stats[4, 1], pos=4, "Third quartile", cex=1.3)
text(1+0.07, box_inf$stats[5, 1], pos=4, "Upper hinge", cex=1.3)
text(1+0.07, box_inf$stats[5, 1]*3, pos=4, "Potential\nOutliers", cex=1.3)


box_inf=boxplot(eclipse_rep$min.response.time+1, log="y",
		boxwex=0.25,
		col="yellow",
		notch=TRUE,
		add=TRUE,
		at=2)


