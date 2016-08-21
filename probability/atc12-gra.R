#
# atc12-gra.R,  6 Aug 16
#
# Data from:
# Generating Realistic Datasets for Deduplication Analysis
# Vasily Tarasov and Amar Mudrankit and Will Buik and Philip Shilane and Geoff Kuenning and Erez Zadok
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


library("igraph")

plot_wide()


atc=read.csv(paste0(ESEUR_dir, "probability/atc12-gra.csv.xz"), as.is=TRUE)
atc_gra=graph.data.frame(atc, directed=TRUE)

V(atc_gra)$size=12
V(atc_gra)$frame.color=NA
V(atc_gra)$color="yellow"
E(atc_gra)$arrow.size=0.5
E(atc_gra)$color="red"
# E(atc_gra)$weight=E(atc_gra)$source
E(atc_gra)$weight=E(atc_gra)$linux
E(atc_gra)$label=E(atc_gra)$weight/100

par(cex=0.9)
# layout.lgl seems to perform better, on average, than the default layout
plot(atc_gra, edge.width=0.3*sqrt(E(atc_gra)$weight), edge.curved=TRUE,
							layout=layout.lgl)

