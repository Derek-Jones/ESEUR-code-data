#
# 587361a.R, 26 Sep 17
# Data from:
# Field studies into the dynamics of product development tasks
# K. E. {van Oorschot} and J. W. M. Bertrand and C. G. Rutte
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")

pal_col=rainbow(8)


proj=read.csv(paste0(ESEUR_dir, "projects/587361a.csv.xz"), as.is=TRUE)

plot(proj$Days, proj$Projects, type="n",
	xlim=c(1, 16),
	xlab="Duration (weeks)", ylab="Projects")

d_ply(proj, .(Estimate), function(df) lines(df$Days, df$Projects, col=pal_col[df$Estimate]))


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
