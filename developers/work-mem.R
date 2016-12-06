#
# work-mem.R, 31 Oct 16
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("diagram")


openplotmat()
elpos=coordinates (c(1, 2, 3))

fromto=matrix(ncol=2, byrow=TRUE, data=c(1, 2, 1, 3,
			 			2, 4, 3, 6,
			 			4, 5, 5, 6))
nr=nrow(fromto)
arrpos=matrix(ncol=2, nrow=nr)
for (i in 1:nr)
   {
   straightarrow(to=elpos[fromto[i, 2], ], from=elpos[fromto[i, 1], ], arr.pos=0.6, arr.length=0.2)
   straightarrow(to=elpos[fromto[i, 1], ], from=elpos[fromto[i, 2], ], arr.pos=0.6, arr.length=0.2)
   }

textellipse(elpos[1,], radx=0.15, 0.1, lab=c("Central", "Executive"),
			 shadow.size=0, box.col="yellow", cex=1.2)
textrect(elpos[2,], 0.175, 0.08,lab=c("Visuo-spatial", "sketch-pad"),
			 shadow.size=0, box.col="yellow", cex=1.2)
textrect(elpos[3,], 0.175, 0.08,lab=c("Phonological", "loop"),
			 shadow.size=0, box.col="yellow", cex=1.2)
textellipse(elpos[4,], radx=0.13, 0.1, lab=c("Visual","semantics"),
			 shadow.size=0, box.col="orange", cex=1.2)
textellipse(elpos[5,], radx=0.13, 0.1, lab=c("Episodic","LTM"),
			 shadow.size=0, box.col="orange", cex=1.2)
textellipse(elpos[6,], radx=0.13, 0.1, lab=c("Language"),
			 shadow.size=0, box.col="orange", cex=1.2)

