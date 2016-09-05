#
# MemoPower03_design.R,  1 Sep 16
#
# Data from:
# "Look It up" or "Do the Math": An Energy, Area, and Timing Analysis of Instruction Resuse and Memoization
# Daniel Citron and Dror G. Feitelson
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


# library("DoE.base")


# Need to fiddle with layout to get plot.design to generate
# labels for everything
layout(matrix(1:1, nrow=1), widths=ESEUR_default_width*1.3, heights=ESEUR_default_height*0.8, TRUE)
# plot_wide()

Memo=read.csv(paste0(ESEUR_dir, "experiment/MemoPower03.csv.xz"), as.is=TRUE)

# plot.design makes odd behavior decisions if the explanatory
# variables are not factors.
Memo$size=as.factor(Memo$size)
Memo$associativity=as.factor(Memo$associativity)
Memo$mapping=as.factor(Memo$mapping)
Memo$replacement=as.factor(Memo$replacement)


plot.design(cint ~ size+associativity+mapping+replacement, data=Memo,
			cex=1.2, cex.lab=1.0, cex.axis=0.9, col=point_col,
			xlab="", ylab="Mean cint\n")


