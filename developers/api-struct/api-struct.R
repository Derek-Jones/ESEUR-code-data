#
# api-struct.R,  6 Apr 15
#
# Data from:
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("seriation")

pal_col=diverge_hcl(10)

fmat=as.matrix(read.table(paste0(ESEUR_dir, "developers/api-struct/similar.08"), as.is=TRUE))

fdist = as.dist(1 - fmat/max(fmat))
fser = seriate(fdist, method="BBURCG")

pimage(fdist, fser, col=pal_col)

