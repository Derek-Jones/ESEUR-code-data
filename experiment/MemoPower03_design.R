#
# MemoPower03_design.R, 25 Jun 20
#
# Data from:
# "Look It up" or "Do the Math": An Energy, Area, and Timing Analysis of Instruction Resuse and Memoization
# Daniel Citron and Dror G. Feitelson
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG


source("ESEUR_config.r")


# library("DoE.base")

par(mar=MAR_default+c(0.7, 0.0, 0, 0))


# Need to fiddle with layout to get plot.design to generate
# labels for everything
# layout(matrix(1:1, nrow=1), widths=ESEUR_default_width*1.3, heights=ESEUR_default_height*0.8, TRUE)
# plot_wide()

Memo=read.csv(paste0(ESEUR_dir, "experiment/MemoPower03.csv.xz"), as.is=TRUE)

# plot.design makes odd behavior decisions if the explanatory
# variables are not factors.
Memo$size=as.factor(Memo$size)
Memo$associativity=as.factor(Memo$associativity)
Memo$mapping=as.factor(Memo$mapping)
Memo$replacement=as.factor(Memo$replacement)


plot.design(cint ~ size+associativity+mapping+replacement, data=Memo,
		cex=1.2, cex.lab=1.2, col=point_col,
		xaxs="i", xaxt="n",
		xlab="", ylab="Mean cint\n")

# Label order is the same as the variable order in the plot formula
text(x=(1:4)+0.3, y=par()$usr[3]-0.03*(par()$usr[4]-par()$usr[3]),
                labels=c("size", "associativity", "mapping", "replacement"),
		pos=2, srt=30, cex=1.2, xpd=TRUE)

