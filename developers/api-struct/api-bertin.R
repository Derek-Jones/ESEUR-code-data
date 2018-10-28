#
# api-bertin.R, 23 Oct 18
#
# Data from:
# Developer characterization of data structure fields decisions
# Derek M. Jones
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG API data-structure field

source("ESEUR_config.r")


library("seriation")
library("grid") # Yes, seriation uses grid graphics
# library("gridExtra")


clust=read.csv(paste0(ESEUR_dir, "developers/api-struct/fieldclust.csv.xz"), as.is=TRUE)
rownames(clust)=clust$Subject
clust$Subject=NULL

fmat=as.matrix(clust)

# An (failed) attempt to get two plots in the same image...
# grid.newpage()
# pushViewport(viewport(layout=grid.layout(1, 2,
# 				widths=unit(rep(0.4, 2), "npc"),
# 				heights=unit(rep(0.9, 2), "npc"))))
# pushViewport(viewport(layout.pos.col=1, layout.pos.row=1))

# bertinplot(fmat, options=list(panel=panel.squares, spacing=0,
# 				mar=c(11, 11, 11, 11),
# 				gp_labels=gpar(cex=0.6, newpage=FALSE)))

fser=seriate(fmat, method="BEA",  control = list(rep = 10))
bertinplot(fmat, fser, options=list(panel=panel.squares, spacing=0,
			mar=c(10, 10, 10, 12),
			gp_panels=gpar(col="grey", fill=point_col),
			gp_labels=gpar(cex=0.6, newpage=FALSE)))


# pushViewport(viewport(width=0.8, height=0.5, angle=10, name="vp1"))
# grid.rect()
# grid.text("top-left corner", x=unit(1, "mm"),
# 			y=unit(1, "npc") - unit(1, "mm"),
# 			just=c("left", "top"))

