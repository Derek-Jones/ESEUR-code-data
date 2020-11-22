#
# ff20-toolkit-dep.R,  3 Nov 20
# Data from:
# How maintainable is the {Firefox} codebase?
# Ali Almossawi
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Firefox_version-20 method_call maintenance_Firefox

source("ESEUR_config.r")


library("grid")  # needed for gpar
library("plyr")
library("seriation")


par(mar=MAR_default-c(2.7, 3.7, 0.5, 0.5))


pal_col=heat_hcl(10)

f20=read.csv(paste0(ESEUR_dir, "sourcecode/ff20-toolkit-dep.csv.xz"), as.is=TRUE)

# Map file path/name to unique number
f_node=unique(f20$From.File)
t_node=unique(f20$To.File)
u_node=unique(c(f20$From.File, f20$To.File))

# graph.data.frame requires first two columns to be from/to
gfx=data.frame(refs=f20$References)
gfx$from=as.numeric(mapvalues(f20$From.File, f_node, 1:length(f_node)))
gfx$to=as.numeric(mapvalues(f20$To.File, t_node, 1:length(t_node)))

# gfx=subset(gfx, !is.na(to))

# Build distance matrix
gfx_mat=matrix(data=0, nrow=length(f_node), ncol=length(f_node))
# gfx_mat[cbind(gfx$from, gfx$to)]=1/gfx$refs
gfx_mat[cbind(gfx$from, gfx$to)]=1+log(gfx$refs)
# gfx_mat[cbind(gfx$from, gfx$to)]=1

# gser=seriate(gfx_mat)
# gser=seriate(gfx_mat, method="BBURCG")
# 
# perm_gfx=permute(gfx_mat, gser)
# 
# pimage(gfx_mat, gser, key=FALSE,
#         xlab="From", ylab="To")

# dissplot(as.dist(gfx_mat))

# Some trial and error finds "binary" gives the best clustering :-O
gfx_dist=dist(gfx_mat, method="binary")
gser=seriate(gfx_dist, col=rev(pal_col), method="TSP")

# Thanks to Michael Hahsler for suggestions

pimage(gfx_dist, gser, key=FALSE, cex=1.2, col=rev(pal_col),
	gp=gpar(cex=1.6), # needs library(grid)
	xlab="From file", ylab="To file")

# mtext("From file", side=1, cex=1.4, outer=TRUE)
# mtext("To file", side=2, cex=1.4, las=0, outer=TRUE)

# Some trial and error finds "binary" gives the best clustering :-O
# t=dissplot(dist(gfx_mat, method="binary"), # key=FALSE, col=rev(pal_col),
# 		method=list(inter="TSP", aggregation="Hausdorff"),	
# 		plot=FALSE)
# 
# Requested support for xlab and ylab
# plot(t, options=list(key=FALSE, col=rev(pal_col)),
# 		xlab="From file", ylab="To file")


