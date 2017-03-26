### R code from vignette source 'hello.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: hello.Rnw:6-11
###################################################
if (!exists("book_R_dont_trash")) rm(list=ls())
op <- options()
options("width"=70, warn=1, str = strOptions(strict.width="wrap", vec.len=2), 
  useFancyQuotes="TeX")
.epsNo <- 0


###################################################
### code chunk number 2: figreset (eval = FALSE)
###################################################
## .iwidth <- 5
## .iheight <- 6
## .ipointsize <- 12
## grey_gamma <- 2.2


###################################################
### code chunk number 3: hello.Rnw:20-21
###################################################
.iwidth <- 5
.iheight <- 6
.ipointsize <- 12
grey_gamma <- 2.2


###################################################
### code chunk number 4: afig (eval = FALSE)
###################################################
## .epsNo <- .epsNo + 1; file <- paste("../Art/Fig-hello-", .epsNo, ".eps", sep="")
## postscript(file=file, onefile = TRUE, paper="special", width = .iwidth, height = .iheight, pointsize = .ipointsize, horizontal=FALSE)


###################################################
### code chunk number 5: zfig (eval = FALSE)
###################################################
## dev.null <- dev.off()
## system(paste("../scripts/mungeEps.sh", file, "3 > outfile ; mv outfile", file, sep=" "))
## cat("\\includegraphics[width=0.95\\textwidth]{", substr(file, 4, nchar(file)), "}\n\n", sep="")


###################################################
### code chunk number 6: afig_png (eval = FALSE)
###################################################
## .epsNo <- .epsNo + 1; file <- paste("../Art/Fig-hello-", .epsNo, ".png", sep="")
## png(filename=file, width = .iwidth, height = .iheight, pointsize = .ipointsize)


###################################################
### code chunk number 7: zfig_png (eval = FALSE)
###################################################
## dev.null <- dev.off()
## cat("\\includegraphics[width=0.95\\textwidth]{", substr(file, 4, nchar(file)), "}\n\n", sep="")


###################################################
### code chunk number 8: hello.Rnw:394-397
###################################################
library(maptools)
library(maps)
library(rgdal)


###################################################
### code chunk number 9: hello.Rnw:402-436
###################################################
.iwidth <- 6
.iheight <- 3.5
.ipointsize <- 10
.epsNo <- .epsNo + 1; file <- paste("../Art/Fig-hello-", .epsNo, ".eps", sep="")
postscript(file=file, onefile = TRUE, paper="special", width = .iwidth, height = .iheight, pointsize = .ipointsize, horizontal=FALSE)
# volc.tab = read.table("data.xy")
volc.tab = read.table("data1964al.xy")
volc = SpatialPoints(volc.tab[c(2,1)])
llCRS <- CRS("+proj=longlat +ellps=WGS84")
proj4string(volc) <- llCRS
prj_new = CRS("+proj=moll")
volc_proj = spTransform(volc, prj_new)
 wrld <- map("world", interior=FALSE, xlim=c(-179,179), ylim=c(-89,89), plot=FALSE)
 wrld_p <- pruneMap(wrld, xlim=c(-179,179))
 wrld_sp <- map2SpatialLines(wrld_p, proj4string=llCRS)
 wrld_proj <- spTransform(wrld_sp, prj_new)
 #save(c("wrld_proj", "wrld_sp"), file = "hsd_data/wrld.RData")
 #load("hsd_data/wrld.RData")
wrld_grd <- gridlines(wrld_sp, easts=c(-179,seq(-150,150,50),179.5), 
  norths=seq(-75,75,15), ndiscr=100)
wrld_grd_proj <- spTransform(wrld_grd, prj_new)
at_sp <- gridat(wrld_sp, easts=0, norths=seq(-75,75,15), offset=0.3)
at_proj <- spTransform(at_sp, prj_new)
opar = par(no.readonly = TRUE)
par(mar=c(1,1,1,1)+0.1, xpd=NA)
plot(wrld_proj, col="grey50")
plot(wrld_grd_proj, add=TRUE, lty=3, col="grey50")
points(volc_proj, cex = .8, pch = 3, col = "blue")
text(coordinates(at_proj), pos=at_proj$pos, offset=at_proj$offset, 
  labels=parse(text=as.character(at_proj$labels)), cex=0.6)
#legend(c(-18000000,-11000000), c(-6000000,-2500000), pch=3, cex = .2, legend=c("volcano"), bty="n") 
par(opar)
# $
dev.null <- dev.off()
system(paste("../scripts/mungeEps.sh", file, "3 > outfile ; mv outfile", file, sep=" "))
cat("\\includegraphics[width=0.95\\textwidth]{", substr(file, 4, nchar(file)), "}\n\n", sep="")
.iwidth <- 5
.iheight <- 6
.ipointsize <- 12
grey_gamma <- 2.2


###################################################
### code chunk number 10: hello.Rnw:573-610
###################################################
.iwidth <- 5
.iheight <- 3.5
.ipointsize <- 9
.epsNo <- .epsNo + 1; file <- paste("../Art/Fig-hello-", .epsNo, ".eps", sep="")
postscript(file=file, onefile = TRUE, paper="special", width = .iwidth, height = .iheight, pointsize = .ipointsize, horizontal=FALSE)
opar = par(no.readonly = TRUE)
par(mar = rep(1,4))
# main:
library(sp)
data(volcano)
grys <- grey.colors(8, 0.55, 0.95, grey_gamma)
layout(matrix(c(1,2,1,3,1,4),3,2,byrow=TRUE), c(3,1))
image(volcano, axes=FALSE, col=grys, asp=1, main="a")
contour(volcano, add=TRUE)
box()
image(volcano, axes=FALSE, col='white', asp=1, main="b")
# b:
library(maptools)
x2 = ContourLines2SLDF(contourLines(volcano))
plot(x2, add=TRUE)
# c:
box()
image(volcano, axes=FALSE, col='white', asp=1, main="c")
plot(x2[x2$level == 140,], add=TRUE)
# d:
box()
image(volcano, axes=FALSE, col=grys, asp=1, main="d")
x3l1 = coordinates(x2[x2$level == 160,])[[1]][[1]]
x3l2 = coordinates(x2[x2$level == 160,])[[1]][[2]]
x3 = SpatialPolygons(list(Polygons(list(Polygon(x3l1,hole=FALSE), 
    Polygon(x3l2,hole=TRUE)), ID=c("x"))))
#plot(x3, col = '#FF880055', add = TRUE) # transp. not supported by EPS
plot(x3, col = '#FF8800', add = TRUE)
box()
par(opar)
dev.null <- dev.off()
system(paste("../scripts/mungeEps.sh", file, "3 > outfile ; mv outfile", file, sep=" "))
cat("\\includegraphics[width=0.95\\textwidth]{", substr(file, 4, nchar(file)), "}\n\n", sep="")
layout(matrix(1))
.iwidth <- 5
.iheight <- 6
.ipointsize <- 12
grey_gamma <- 2.2


###################################################
### code chunk number 11: hello.Rnw:1013-1017
###################################################
sI <- capture.output(print(sessionInfo()))
cat(paste("%", sI[1:(length(sI)/2)], sep=" "), sep="\n")
sT <- capture.output(print(Sys.time()))
cat("%", sT, "\n")


###################################################
### code chunk number 12: hello.Rnw:1020-1021
###################################################
options(op)


