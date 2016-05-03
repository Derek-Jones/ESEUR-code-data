#
# MemoPower03_interact.R, 26 Mar 16
#
# Data from:
# "Look It up" or "Do the Math": An Energy, Area, and Timing Analysis of Instruction Resuse and Memoization
# Daniel Citron and Dror G. Feitelson
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

plot_layout(1, 2)

Memo=read.csv(paste0(ESEUR_dir, "experiment/MemoPower03.csv.xz"), as.is=TRUE)

# plot.design makes odd behavior decisions if the explanatory
# variables are not factors.
Memo$size=as.factor(Memo$size)
Memo$associativity=as.factor(Memo$associativity)
Memo$mapping=as.factor(Memo$mapping)
Memo$replacement=as.factor(Memo$replacement)

# Using with means we get a more sensible label names
with(Memo,
	interaction.plot(size, associativity, cint,
		cex=1.3, col="brown",
		xlab="size", ylab="Mean cint performance\n"))
with(Memo,
	interaction.plot(size, mapping, cint,
		cex=1.3, col="brown",
		xlab="size", ylab="Mean cint performance"))

