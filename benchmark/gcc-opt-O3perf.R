#
# gcc-opt-O3perf.R, 23 Nov 17
# Data from:
# SPEC2000 results for various versions of gcc, obtained from:
# Vladimir N. Makarow http://vmakarov.fedorapeople.org/spec/index.html
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("lattice")
library("plyr")
library("reshape2")


plot_prog=function(df)
{
lines(df$gcc.version, df$value, col=df$col)
}


int2k_64=read.csv(paste0(ESEUR_dir, "benchmark/gcc-opt-int2k-64.csv.xz"), as.is=TRUE)

bc_64=int2k_64[int2k_64$Kind == "Bench.Change", ]
O3_64=bc_64[bc_64$Opt == "O3", ]

# Strip "v" off version number
colnames(O3_64)=c(colnames(O3_64)[1:3], substr(colnames(O3_64[, 4:9]), 2, 10))
lp=melt(O3_64[,3:9], variable.name="gcc.version", id="Name")

# gcc_v=unique(lp$gcc.version)
# progs=unique(lp$Name)
# pal_col=rainbow(length(progs))
# lp$col=pal_col[as.numeric(mapvalues(lp$Name, progs, 1:length(progs)))]
# 
# plot(0, type="n",
# 	xaxt="n",
#  	xlim=c(1, length(gcc_v)), ylim=range(lp$value),
# 	xlab="gcc version", ylab="Performance change (percentage)\n")
# axis(1, at=1:length(gcc_v), labels=gcc_v)
# d_ply(lp, .(Name), plot_prog)
# 
# legend(x="topleft", legend=progs, bty="n", fill=pal_col, cex=1.1)

t=xyplot(value ~ gcc.version | Name, data=subset(lp, Name != "SPECint2000"),
	col=point_col, pch=point_pch, type="b",
	xlab="gcc version", ylab="Percentage performance change",
                par.strip.text=list(cex=0.75),
                scales=list(x=list(cex=0.5)),
	panel=function(...) {panel.abline(0, 0, col="grey"); panel.xyplot(...)})

plot(t, panel.height=list(2.5, "cm"),
		panel.width=list(3.0, "cm"))

