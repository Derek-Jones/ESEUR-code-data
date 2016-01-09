#
# icpe13_datamill_xy.R,  8 Jan 16
#
# Data from:
# DataMill: Rigorous Performance Evaluation Made Easy
# Augusto Born de Oliveira and Jean-Christophe Petkovich and Thomas Reidemeister and Sebastian Fischmeister
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")


plot_perf=function(df)
{
points(df$opt_flag, df$task_clock, col=pal_col[col_num])
t=ddply(df, .(opt_flag), function(df) mean(df$task_clock))

lines(t$opt_flag, t$V1, col=pal_col[col_num])
col_num <<- col_num+1

}


bench=read.csv(paste0(ESEUR_dir, "benchmark/icpe13_datamill_xy.csv.xz"), as.is=TRUE)


# 129.97.68.195 A 1.6GHz Nano X2
# 129.97.68.196 B 1.5GHz Xeon
# 129.97.68.204 C 600MHz ARM
# 129.97.68.206 D 600MHz ARM
# 129.97.68.208 E 3.2GHz P4
# 129.97.68.213 F 3.4GHz i7
# 129.97.68.214 G 3.3GHz i5
# 129.97.69.162 H 3.2GHz P4
# 129.97.69.168 I 1.6GHz P4
# 129.97.69.182 J 3.0GHz Pentium D
# 129.97.69.195 K 1.6GHz P4
# 129.97.69.198 L 150MHz Celeron

processors=c("1.6GHz Nano X2","600MHz ARM","3.2GHz P4","3.4GHz i7","3.3GHz i5","1.6GHz P4","1.6GHz P4")
opt_levels=c("-O0", "-O1", "-Os", "-O2", "-O3")
bench$opt_flag=mapvalues(bench$opt_flag, opt_levels, 1:length(opt_levels))

xsub = subset(bench, type=="xz")

pal_col=rainbow(length(unique(xsub$hostname)))

ybounds=range(xsub$task_clock)

plot(1, type="n",
	xlim=c(1, length(opt_levels)), ylim=ybounds,
	xaxt="n",
	xlab="Optimization level", ylab="Clock time (ms)\n")

axis(1, at=1:length(opt_levels), labels=opt_levels)

col_num=1
d_ply(xsub, .(hostname), plot_perf)

legend(x="topright", legend=processors, bty="n", fill=pal_col, cex=1.3)


