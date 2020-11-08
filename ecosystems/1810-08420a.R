#
# 1810-08420a.R, 27 Oct 20
# Data from:
# Why is a {Ravencoin} Like a {TokenDesk}? {An} Exploration of Code Diversity in the Cryptocurrency Landscape
# "Pierre Reibel and Haaroon Yousaf and Sarah Meiklejohn
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG cryptocurrency_source-code platform_similarity

source("ESEUR_config.r")


library("ape")


plot_layout(1, 1, default_height=10.8)
par(mar=MAR_default-c(0.0, 3.7, 0, 1))

pal_col=rainbow(2)

dsim=read.csv(paste0(ESEUR_dir, "ecosystems/1810-08420a.csv.xz"), as.is=TRUE)

tsim=as.matrix(dsim)

s_dist=dist(tsim)

cryp_phy=nj(s_dist)

plot(cryp_phy, cex=0.1, tip.color=pal_col[1], edge.color=pal_col[2])


