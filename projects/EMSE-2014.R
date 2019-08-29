#
# EMSE-2014.R, 18 May 18
# Data from:
# How the {Apache} Community Upgrades Dependencies: {An} Evolutionary Study?
# Gabriele Bavota and Gerardo Canfora and Massimiliano {Di Penta} and Rocco Oliveto and Sebastiano Panichella
# Kindly provided by Panichella
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Java dependencies evolution projects


source("ESEUR_config.r")


library("seriation")
library("grid") # Yes, seriation uses grid graphics


pal_col=heat_hcl(10)


ap2013=read.csv(paste0(ESEUR_dir, "projects/EMSE-2013Ordered.csv.xz"), as.is=TRUE, sep="\t", header=FALSE)
projs=read.csv(paste0(ESEUR_dir, "projects/EMSE-Names.txt"), as.is=TRUE)

# projs$nameProject=sub("_", "", projs$nameProject)

colnames(ap2013)=projs$nameProject
rownames(ap2013)=projs$nameProject

pmat=as.matrix(ap2013)

fser=seriate(pmat)

pimage(pmat, fser, col=rev(pal_col), key=FALSE, cex.lab=1.6,
	xlab="Projects", ylab="Projects")

