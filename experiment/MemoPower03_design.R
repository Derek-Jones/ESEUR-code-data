#
# MemoPower03_design.R,  8 Jan 16
#
# Data from:
# "Look It up" or "Do the Math": An Energy, Area, and Timing Analysis of Instruction Resuse and Memoization
# Daniel Citron and Dror G. Feitelson
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

par(fin=c(4.5, 3.5))


Memo=read.csv(paste0(ESEUR_dir, "experiment/MemoPower03.csv.xz"), as.is=TRUE)

# plot.design makes odd behavior decisions if the explanatory
# variables are not factors.
Memo$size=as.factor(Memo$size)
Memo$associativity=as.factor(Memo$associativity)
Memo$mapping=as.factor(Memo$mapping)
Memo$replacement=as.factor(Memo$replacement)


plot.design(cint ~ size+associativity+mapping+replacement, data=Memo,
			cex=1.3, col="blue",
			ylab="Mean of cint\n")


