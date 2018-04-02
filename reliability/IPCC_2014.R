#
# IPCC_2014.R,  2 Jan 18
# Data from:
# The interpretation of {IPCC} probabilistic statements around the world
# David V. Budescu and Han-Hui Por and Stephen B. Broomell and Michael Smithson
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")


plot_mean=function(df)
{
points(df$Mean, type="b", col=pal_col[df$Country[1]])
}

ipcc=read.csv(paste0(ESEUR_dir, "reliability/IPCC_2014.csv.xz"), as.is=TRUE)

pal_col=rainbow(length(unique(ipcc$Country)))
ipcc$Country=as.factor(ipcc$Country)

trans=subset(ipcc, Condition == "Translation")

plot(0, type="n",
	xaxt="n",
	xlim=c(1, 4), ylim=range(trans$Mean),
	xlab="", ylab="Likelihood (percentage)\n")
x_at=1:4
axis(1, at=x_at, labels=FALSE)
text(x=x_at+0.3, y=par()$usr[3]-0.03*(par()$usr[4]-par()$usr[3]),
                labels=trans$Term[1:4], pos=2, srt=30, cex=1.1, xpd=TRUE)

d_ply(trans, .(Country), plot_mean)

