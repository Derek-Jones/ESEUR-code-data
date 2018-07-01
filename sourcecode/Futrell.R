#
# Futrell.R,  1 May 18
# Data from:
# Large-scale evidence of dependency length minimization in 37 languages
# Richard Futrell and Kyle Mahowald and Edward Gibson
# Figure 1
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("diagram")


numwords = 5
DiffMat = matrix(data = 0, nrow = numwords, ncol = numwords)
AA = as.data.frame(DiffMat)
AA[[1, 2]] = "1"
AA[[3, 2]] = "1"
AA[[4, 5]] = "1"
AA[[5, 2]] = "3"
#
name = c("John", "threw", "out", "the", "trash")

plotmat(AA, pos = numwords, curve = 0.3, name = name, main="", cex=1.2,
	my=0.2,
	arr.len = 0.15, arr.width = 0.1, arr.lcol="green",
	box.lcol="white", box.prop=0.5, box.size=0.05, box.cex=1.2, shadow.size=0)

AA = as.data.frame(DiffMat)
AA[[1, 2]] = "1"
AA[[4, 2]] = "2"
AA[[3, 4]] = "1"
AA[[5, 2]] = "3"
#
name = c("John", "threw", "the", "trash", "out")

plotmat(AA, pos = numwords, curve = 0.3, name = name, main="", cex=1.2,
	my=-0.2, add=TRUE,
	arr.len = 0.15, arr.width = 0.1, arr.lcol="green",
	box.lcol="white", box.prop=0.5, box.size=0.05, box.cex=1.2, shadow.size=0)

