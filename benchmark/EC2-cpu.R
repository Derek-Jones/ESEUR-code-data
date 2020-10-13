#
# EC2-cpu.r,  8 Apr 20
#
# Data from:
# Runtime Measurements in the Cloud: Observing, Analysing, and Reducing Variance
# J\"{o}rg Schad and Jens Dittrich and Jorge-Arnulfo Quian\'{e}-Ruiz
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG benchmark_cloud measurement_variance


source("ESEUR_config.r")


plot_layout(2, 1)
par(mar=MAR_default+c(0.0, 0.7, 0, 0))


brew_col=rainbow(2)

#date	time	x1	Ubench	location	x2	x3	x4	year	x6
# "2009-12-14"	"00:52:24.940122"	0	0	"\N"		0	14	2009	0
LargeEU=read.csv(paste0(ESEUR_dir, "benchmark/cpuLargeEU.csv.xz"), sep="\t", as.is=TRUE)

LargeEU$seconds=as.POSIXct(paste0(LargeEU$date, " ", LargeEU$time),
			format="%Y-%m-%d %I:%M:%s")

plot(LargeEU$seconds, LargeEU$Ubench, col=brew_col[1],
	xaxs="i",
	xlab="2009-2010", ylab="Ubench cpu performance\n\n")

LargeUS=read.csv(paste0(ESEUR_dir, "benchmark/cpuLargeUS.csv.xz"), sep="\t", as.is=TRUE)

LargeUS$seconds=as.POSIXct(paste0(LargeUS$date, " ", LargeUS$time),
			format="%Y-%m-%d %I:%M:%s")

points(LargeUS$seconds, LargeUS$Ubench, col=brew_col[2])

# 12/14/09	00:52:24.94	0	0	"eu-west-1a\"	0	0	14	2009	0
SmallEU=read.csv(paste0(ESEUR_dir, "benchmark/cpuSmallEU.csv.xz"), sep="\t", as.is=TRUE)

SmallEU$seconds=as.POSIXct(paste0(SmallEU$date, " ", SmallEU$time),
			format="%m/%d/%y %I:%M:%s")

plot(SmallEU$seconds, SmallEU$Ubench, col=brew_col[1],
	xaxs="i",
	xlab="2009-2010", ylab="Ubench cpu performance\n\n")

SmallUS=read.csv(paste0(ESEUR_dir, "benchmark/cpuSmallUS.csv.xz"), sep="\t", as.is=TRUE)

SmallUS$seconds=as.POSIXct(paste0(SmallUS$date, " ", SmallUS$time),
			format="%m/%d/%y %I:%M:%s")

points(SmallUS$seconds, SmallUS$Ubench, col=brew_col[2])


