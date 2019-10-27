#
# 587361a.R,  6 Oct 19
# Data from:
# Field studies into the dynamics of product development tasks
# K. E. {van Oorschot} and J. W. M. Bertrand and C. G. Rutte
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG project_duration management_estimate

source("ESEUR_config.r")


library("plyr")

pal_col=rainbow(8)


# Draw normalised line
estimate_line=function(df)
{
tot_proj=sum(df$Projects)

lines(df$Days, 100*df$Projects/tot_proj, col=pal_col[df$Estimate])
}


proj=read.csv(paste0(ESEUR_dir, "projects/587361a.csv.xz"), as.is=TRUE)

plot(proj$Days, proj$Projects, type="n",
	yaxs="i",
	xlim=c(1, 18), ylim=c(0, 50),
	xlab="Duration (weeks)", ylab="Projects (percentage)\n")

d_ply(proj, .(Estimate), estimate_line)

legend(x="topright", legend=paste0(1:8, " weeks"), bty="n", fill=pal_col, cex=1.2)

# Overlay an estimated lognormal distribution...
# Est=4
# 
# t4=subset(proj, Estimate == Est)
# plot(t4$Days, t4$Projects, col=pal_col[t4$Estimate])
# 
# xvals=1:15
# 
# points(xvals, sum(t4$Projects)*dlnorm(xvals, meanlog=log(Est), sdlog=0.4), col="red")
# 
