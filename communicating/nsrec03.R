#
# nsrec03.R, 22 Aug 18
# Data from:
# In-Flight Observations of Long-Term Single-Event Effect ({SEE}) Performance on {Orbview-2} Solid State Recorders ({SSR})
# Christian Poivey and Janet L. Barth and Kenneth A. LaBel and George Gee and Harvey Safren
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG cosmic-ray hardware fault memory


source("ESEUR_config.r")

# Code below based on Figure 1.1 in Applied Spatial Analysis with R
# by Bivand, Rebesma and Gomez-Rubio


library(maptools)
library(maps)
library(sp)
# library(rgdal)

par(mar=c(1,1,1,1)+0.1, xpd=NA)

nsrec=read.csv(paste0(ESEUR_dir, "communicating/nsrec03.csv.xz"), as.is=TRUE)
event_coord=SpatialPoints(cbind(nsrec$Longitude, nsrec$Latitude))

llCRS = CRS("+proj=longlat +ellps=WGS84")
# proj4string(event_coord) = llCRS
# prj_new = CRS("+proj=moll")
# event_coord_proj = spTransform(event_coord, prj_new)

world = map("world", interior=FALSE, xlim=c(-179,179), ylim=c(-89,89), plot=FALSE)
world_p = pruneMap(world, xlim=c(-179,179))
world_sp = map2SpatialLines(world, proj4string=llCRS)
# world_proj = spTransform(world_sp, prj_new)
world_grd = gridlines(world_sp, easts=c(-179,seq(-150,150,50),179.5), 
				norths=seq(-75,75,15), ndiscr=100)
# world_grd_proj = spTransform(world_grd, prj_new)
# at_sp = gridat(world_sp, easts=0, norths=seq(-75,75,15), offset=0.3)
# at_proj = spTransform(at_sp, prj_new)

plot(world_sp, col=point_col)
plot(world_grd, add=TRUE, lty=3, col="grey50")
points(event_coord, cex = .5, pch = "+", col = "blue")


# plot(world_proj, col="grey50")
# plot(world_grd_proj, add=TRUE, lty=3, col="grey50")

# text(coordinates(at_proj), pos=at_proj$pos, offset=at_proj$offset, 
#		labels=parse(text=as.character(at_proj$labels)), cex=0.6)

