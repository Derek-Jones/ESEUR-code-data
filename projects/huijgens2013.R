#
# huijgens2013.R, 24 May 20
# Data from:
# Measuring Best-in-Class Software Releases
# Hennie Huijgens and Rini van Solingen

# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG requirement_cost function-point_cost story-point_cost

source("ESEUR_config.r")


plot_layout(2, 1)
pal_col=rainbow(3)


cost_ratio=function(project)
{
plot(project$Date, project$Cost/project$FP, type="b", col=pal_col[2],
	yaxs="i",
	ylim=c(0, max(project$Cost/project$Req)),
	xlab="Date", ylab="Cost per\n")

points(project$Date, project$Cost/project$SP, type="b", col=pal_col[3])
points(project$Date, project$Cost/project$Req, type="b", col=pal_col[1])

legend(x="topright", legend=c("Requirements", "Function points", "Story points"), bty="n", fill=pal_col, cex=1.2)
}


pal_col=rainbow(3)

AB=read.csv(paste0(ESEUR_dir, "projects/huijgens2013.csv.xz"), as.is=TRUE)
AB$Date=as.Date(paste0(AB$Date, "-01"), format="%Y-%m-%d")

A_cost=subset(AB, System == "A")
B_cost=subset(AB, System == "B")


cost_ratio(A_cost)
cost_ratio(B_cost)


