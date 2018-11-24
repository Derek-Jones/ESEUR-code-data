#
# MemoPower03_cube.R,  5 Nov 18
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


library("FrF2")


Memo=read.csv(paste0(ESEUR_dir, "experiment/MemoPower03.csv.xz"), as.is=TRUE)
Memo$mapping=paste0(Memo$mapping, " ")

Memo$size=as.factor(Memo$size)
Memo$associativity=as.factor(Memo$associativity)
Memo$mapping=as.factor(Memo$mapping)
Memo$replacement=as.factor(Memo$replacement)

Memo_3=subset(Memo, replacement == "lru")

# Have reported that there is no support for changing colors via an argument.
cur_par=par()
par(col=point_col)

with(Memo_3,
   cubePlot(cint, size, associativity, mapping,
		main="", cex.lab=0.9, cex.clab=1.25, size=0.35, round=1))

par(col=cur_par$col)

