#
# 1014.R, 26 Mar 16
#
# Data from:
#
# Implementation of Fault Slip Through in Design Phase of the Project
# Lovre Hribar
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("lattice")

FST=read.csv(paste0(ESEUR_dir, "reliability/1014.csv.xz"), as.is=TRUE,
			row.names=1)


FST=as.matrix(FST)
# Rotate clockwise by 90 degrees
FST=t(apply(FST, 2, rev))

t=levelplot(FST,
                xlab="", ylab="",
		scales=list(x=list(cex=0.75, rot=25), y=list(cex=0.75)),
                panel=function(...)
                        {
                        panel.levelplot(...)
                        panel.text(1:5, rep(1:5, each=5), FST, cex=0.7)
                        })
plot(t, panel.height=list(3.8, "cm"), panel.width=list(4.2, "cm"))


