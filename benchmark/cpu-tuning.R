#
# cpu-tuning.R, 19 Aug 16
#
# Data from:
# Software knows best: A case for hardware transparency and measureability
# Bird
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("lattice")


cpu_perf=read.csv(paste0(ESEUR_dir, "benchmark/bird_perf-port.csv.xz"), as.is=TRUE)

perf_27=subset(cpu_perf, Points == 27)
perf_27$Points=NULL
rownames(perf_27)=perf_27$CPU
perf_27$CPU=NULL

# add_value=function()
# {
# t=expand.grid(1:6, 1:5)
# text(t, labels=as.vector(t(as.matrix(perf_27))), cex=2.0)
# }
# 
# 
# par(omi=c(0.1, 0.00, 0.00, 0.4))
# 
# It is possible to get heatmap to produce something reasonable
# brew_col=rainbow_hcl(5)
#
# heatmap(as.matrix(perf_27), Rowv=NA, Colv=NA, RowSideColors=brew_col, col=brew_col,
#	add.expr=add_value())

perf_27=as.matrix(perf_27)
perf_27=t(perf_27)

t=levelplot(perf_27,
#		col.regions=rainbow(100, end=0.9),
# Not as garish
		col.regions=rainbow_hcl(100),
		scales=list(x=list(cex=0.70, rot=25), y=list(cex=0.65)),
		colorkey=NULL, # Numeric values remove the need for legend
		xlab="Tuned for", ylab="Executed on",
		panel=function(...)
			{
			panel.levelplot(...)
			panel.text(1:6, rep(1:5, each=6), perf_27, cex=0.65)
			})

plot(t, panel.height=list(3.8, "cm"), panel.width=list(4.2, "cm"))


