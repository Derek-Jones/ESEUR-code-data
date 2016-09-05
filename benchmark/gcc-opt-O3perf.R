#
# gcc-opt-O3perf.R, 31 Aug 16
#
# SPEC2000 results for various versions of gcc, obtained from:
# Vladimir N. Makarow http://vmakarov.fedorapeople.org/spec/index.html
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("lattice")
library("reshape2")


int2k_64=read.csv(paste0(ESEUR_dir, "benchmark/gcc-opt-int2k-64.csv.xz"), as.is=TRUE)

bc_64=int2k_64[int2k_64$Kind == "Bench.Change", ]
O3_64=bc_64[bc_64$Opt == "O3", ]

# Strip "v" off version number
colnames(O3_64)=c(colnames(O3_64)[1:3], substr(colnames(O3_64[, 4:9]), 2, 10))
lp=melt(O3_64[,3:9], variable.name="gcc.version", id="Name")

t=xyplot(value ~ gcc.version | Name, data=subset(lp, Name != "SPECint2000"),
	col=point_col, pch=point_pch, type="b",
	xlab="gcc version", ylab="Percentage performance change",
                par.strip.text=list(cex=0.75),
                scales=list(x=list(cex=0.5)),
	panel=function(...) {panel.abline(0, 0, col="grey"); panel.xyplot(...)})

plot(t, panel.height=list(2.5, "cm"),
		panel.width=list(3.0, "cm"))

