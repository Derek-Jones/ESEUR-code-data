#
# rotate-illusion.r,  4 Jan 14

# Code copied from:
# http://rpubs.com/kohske/R-de-illusion
# http://www.fennel.rcast.u-tokyo.ac.jp/profilej_ktakahashi.html


library("grid")

nt <- 41; nr <- 15; br <- 0.8
col1 <- c("black", "white")
col2 <- c("aquamarine4", "gold2")

f <- function(x0, y0) {
  r <- embed(br^(0:nr), 2)
  t <- embed(seq(0, 2*pi, length=nt), 2)
  i <- as.matrix(expand.grid(1:nrow(r), 1:nrow(t)))
  ci <- 1 + (i[,2]%%2 + i[,1]%%2) %% 2

  p <- t(apply(i, 1, function(x) c(r[x[1], ], t[x[2], ])))
  x <- c(p[,1]*cos(p[,3]), p[,1]*cos(p[,4]), p[,2]*cos(p[,4]), p[,2]*cos(p[,3]))
  y <- c(p[,1]*sin(p[,3]), p[,1]*sin(p[,4]), p[,2]*sin(p[,4]), p[,2]*sin(p[,3]))
  grid.polygon(x0+x/2, y0+y/2, id = rep.int(1:nrow(p), 4),
               gp = gpar(fill = col1[ci], col=NA), default.units="native")

  p <- expand.grid(1:nrow(r), sign((abs(x0-y0)==1)-0.5)*seq(0, 2*pi, length=41)[-1])
  p <- cbind(p[,2], rowMeans(r)[p[,1]], (r[,2]-r[,1])[p[,1]]/2)
  t <- seq(0, 2*pi, length=20)[-1]
  x <- c(apply(p, 1, function(a) a[2]*cos(a[1])+a[3]*(cos(a[1])*cos(t)-0.5*sin(a[1])*sin(t))))
  y <- c(apply(p, 1, function(a) a[2]*sin(a[1])+a[3]*(sin(a[1])*cos(t)+0.5*cos(a[1])*sin(t))))
  col <- if(abs(x0-y0)==1) {col2} else {rev(col2)}
  grid.polygon(x0+x/2, y0+y/2, id = rep(1:nrow(p), each=length(t)),
               gp = gpar(fill = col[ci], col=NA), default.units="native")

}

grid.newpage()
# Original used c(0, 3)
# pushViewport(viewport(xscale = c(0, 3), yscale = c(0, 3)))
pushViewport(viewport(xscale = c(0, 4), yscale = c(0, 4)))
for (x0 in 0.5+0:2) for (y0 in 0.5+0:2) f(x0, y0)
for (x0 in 1:2) for (y0 in 1:2) f(x0, y0)

