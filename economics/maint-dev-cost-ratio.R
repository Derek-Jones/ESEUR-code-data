#
# maint-dev-cost-ratio.R, 10 Jul 17
#
# Data from:
# An Investigation of the Factors Affecting the Lifecycle Costs of COTS-Based Systems
# Laurence Michael Dunn
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


# library(fitdistrplus)


pal_col=rainbow(2)


dme=read.csv(paste0(ESEUR_dir,"economics/dev-maint-effort.csv.xz"), as.is=TRUE)


y=sort(dme$dev.effort/dme$maint.effort, decreasing=TRUE)
#descdist(y, boot=100)

# and the reason this is not a regression fit???
# t=fitdist(y/(max(y)+1), distr="beta", start=list(shape1=0.2, shape2=10), method="mle")
#summary(t)
# tb=dbeta(seq(1/length(y), 1, by=1/length(y)), shape1=t$estimate[1], shape2=t$estimate[2])

# fitdist requires values in [0, 1] while dbeta can return values
# outside that range, so some scaling is required.  We could do
# lots of work and get it correct, choose the first element to align
# or do it by eye (10 looks good).
#norm=dbeta(1/length(y), shape1=t$estimate[1], shape2=t$estimate[2])
# norm=10
# 
# plot(tb*max(y)/norm, type="l", log="y", col=pal_col[1],
# 	ylim=c(0.01, 12),
# 	xlab="Systems", ylab="Development/Maintenance\n")
# points(y, col=pal_col[2])

# Harmonic mean of single year maintenance, i.e., d/m
# 1/mean(1/(y*5))

plot(y, log="y", col=point_col,
	ylim=c(0.01, 12),
	xlab="Systems", ylab="Development/Maintenance\n")

