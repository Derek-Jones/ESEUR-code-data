#
# MemoPower03_interact.R,  5 Nov 18
#
# Data from:
# "Look It up" or "Do the Math": An Energy, Area, and Timing Analysis of Instruction Resuse and Memoization
# Daniel Citron and Dror G. Feitelson
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment performance SPEC hardware-characteristics


source("ESEUR_config.r")


# plot_layout(2, 1)

Memo=read.csv(paste0(ESEUR_dir, "experiment/MemoPower03.csv.xz"), as.is=TRUE)

# plot.design makes odd behavior decisions if the explanatory
# variables are not factors.
Memo$size=as.factor(Memo$size)
Memo$associativity=as.factor(Memo$associativity)
Memo$mapping=as.factor(Memo$mapping)
Memo$replacement=as.factor(Memo$replacement)

# Using with means we get a more sensible label names
# with(Memo,
# 	interaction.plot(size, associativity, cint,
# 		cex=1.3, col=point_col,
# 		xlab="size", ylab="Mean cint performance\n"))

with(Memo,
	interaction.plot(size, mapping, cint,
		cex=1.3, col=point_col,
		xlab="size", ylab="Mean cint performance"))

