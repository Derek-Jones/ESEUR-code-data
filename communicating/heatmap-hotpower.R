#
# heatmap-hotpower.R, 26 Mar 15
#
# Data from:
# Memory Performance at Reduced {CPU} Clock Speeds: {An} Analysis of Current x86\_64 Processor
# Robert Sch{\"o}ne and Daniel Hackenberg and Daniel Molka
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("lattice")


L3_band=read.csv(paste0(ESEUR_dir, "communicating/hotpower12_L3-cache.csv.xz"),
		as.is=TRUE, row.names=1, check.names=FALSE)

L3_band=as.matrix(L3_band)
L3_band=L3_band[rev(seq_len(nrow(L3_band))), ]

t=levelplot(L3_band,
		col.regions=rainbow(100, end=0.9),
		xlab="Clock frequency (Mhz)", ylab="Cores used",
                scales=list(x=list(cex=0.70, rot=35), y=list(cex=0.65)),
		panel=function(...)
			{
			panel.levelplot(...)
			panel.text(1:11, rep(1:8, each=11), L3_band, cex=0.55)
			})

plot(t, panel.height=list(3.8, "cm"), panel.width=list(6.2, "cm"))

# library("gplots")
# 
# heatmap.2(L3_band, Rowv=FALSE, Colv=FALSE,
#         trace="none", dendrogram="none", key=FALSE, density.info="none",
# 	col=rainbow(100, end=0.9),
# 	cellnote=L3_band, notecol="black")


