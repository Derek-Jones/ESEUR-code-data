#
# decide-mean.R, 13 Mar 15
#
# From (page 55):
# Data Quality Assessment: Statistical Methods for Practitioners
# EPA QA/G-9S
# United States Environmental Protection Agency
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("diagram")


openplotmat()
elpos = coordinates (c(1, 3, 2, 8))
fromto = matrix(ncol = 2, byrow = TRUE,
		data = c(1, 2, 1, 3, 1, 4,
			 3, 5, 3, 6,
			 2, 7, 2, 8,
			 5, 9, 5, 10,
			 6, 11, 6, 12,
			 4, 13, 4, 14))
nr = nrow(fromto)
arrpos=sapply(1:nr, function(X)
		 straightarrow(from = elpos[fromto[X, 1], ],
				to = elpos[fromto[X, 2], ],
				lwd = 2, arr.pos = 0.9, arr.length = 0.5))

#
text(arrpos[1, 1], arrpos[2, 1], "One sample", srt=40, adj=c(-0.0, -0.1))
text(arrpos[1, 2], arrpos[2, 2], "Two sample", pos=3, adj=c(-1.0, 0))
text(arrpos[1, 3], arrpos[2, 3], "K sample", srt=-40, pos=2, adj=c(-0.4, 0.1))

text(arrpos[1, 4], arrpos[2, 4], "Parametric", srt=40, adj=c(-0.0, -0.1))
text(arrpos[1, 5], arrpos[2, 5], "Nonparametric", srt=-40, pos=2, adj=c(-0.4, 0.1))

text(arrpos[1, 6], arrpos[2, 6], "Parametric", srt=75, adj=c(-0.0, -0.1))
text(arrpos[1, 7], arrpos[2, 7], "Nonparametric", srt=-75, pos=2, adj=c(-0.4, 0.1))

text(arrpos[1, 8], arrpos[2, 8], "Independent")
text(arrpos[1, 9], arrpos[2, 9], "Paired")

text(arrpos[1, 10], arrpos[2, 10], "Independent")
text(arrpos[1, 11], arrpos[2, 11], "Paired")

text(arrpos[1, 12], arrpos[2, 12], "Parametric", srt=75, adj=c(-0.0, -0.1))
text(arrpos[1, 13], arrpos[2, 13], "Nonparametric", srt=-75, pos=2, adj=c(-0.4, 0.1))


textrect(elpos[7,], 0.15, 0.05, box.col="yellow",
	angle=90, srt=90,
	lab = "t-test and CI\nStratefied t-test\nChen test\nLand's CI method\nTest for proportion and CI")
textrect(elpos[8,], 0.15, 0.05, box.col="yellow",
	angle=90, srt=90,
	lab = "Signtest\nWilcoxon Signed ranks test")
textrect(elpos[9,], 0.15, 0.05, box.col="yellow",
	angle=90, srt=90,
	lab = "t-test and CI\nTest for proportion and CI")
textrect(elpos[10,], 0.15, 0.05, box.col="yellow",
	angle=90, srt=90,
	lab = "Paired t-test")
textrect(elpos[11,], 0.15, 0.05, box.col="yellow",
	angle=90, srt=90,
	lab = "Wilcoxon Rank sum test\nQuantile test\nSlippage test")
textrect(elpos[12,], 0.15, 0.05, box.col="yellow",
	angle=90, srt=90,
	lab = "Sign test\nWilcoxon Signed rank test")
textrect(elpos[13,], 0.15, 0.05, box.col="yellow",
	angle=90, srt=90,
	lab = "Dunnett's test")
textrect(elpos[14,], 0.15, 0.05, box.col="yellow",
	angle=90, srt=90,
	lab = "Kruskal-Wallis test")

