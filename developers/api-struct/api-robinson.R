#
# api-robinson.R, 18 May 18
#
# Data from:
# Developer characterization of data structure fields decisions
# Derek M. Jones
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("seriation")
library("grid") # Yes, seriation uses grid graphics


pal_col=heat_hcl(10)

fields=read.csv(paste0(ESEUR_dir, "developers/api-struct/similar_08.csv.xz"), as.is=TRUE)
rownames(fields)=colnames(fields)

fmat=as.matrix(fields)

fdist = as.dist(1 - fmat/max(fmat))
fser = seriate(fdist, method="BBURCG")

pimage(fdist, fser, col=rev(pal_col), key=FALSE, gp=gpar(cex=0.8))

