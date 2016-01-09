#
# spec-cache.R,  8 Jan 16
#
# Data from:
# Improving Accuracy of Software Performance Models on Multicore Platforms with Shared Caches
# Vlastimil Babka
# Code adapted from that kindly provided by: Vlastimil Babka
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


par(fin=c(4.5, 3.5))

isol=read.csv(paste0(ESEUR_dir, "benchmark/babkatuma/tbl_isol_means.tbl"), sep=" ", as.is=TRUE)
hit=read.csv(paste0(ESEUR_dir, "benchmark/babkatuma/tbl_hit_means.tbl"), sep=" ", as.is=TRUE)
miss=read.csv(paste0(ESEUR_dir, "benchmark/babkatuma/tbl_miss_means.tbl"), sep=" ", as.is=TRUE)
cap=read.csv(paste0(ESEUR_dir, "benchmark/babkatuma/tbl_cap_means.tbl"), sep=" ", as.is=TRUE)
mem=read.csv(paste0(ESEUR_dir, "benchmark/babkatuma/tbl_mem_miss_means.tbl"), sep=" ", as.is=TRUE)

pal_col=rainbow(4)


ordr=order(-isol$L2_LINES_IN.SELF.ALL/isol$time)


barplot(rbind(hit$time[ordr]/isol$time[ordr]*100-100,
		miss$time[ordr]/isol$time[ordr]*100-100,
		cap$time[ordr]/isol$time[ordr]*100-100,
		mem$time[ordr]/isol$time[ordr]*100-100),
	beside=TRUE, col=pal_col,
	ylab="Slowdown percentage\n",
	names.arg=apply(t(isol$benchmark[ordr]), 1, substring,1,8), las=2,
	args.legend=list(x="topright", bty="n", cex=1.3),
	legend.text=c("shared cache: Hits",
			"shared cache: Conflict misses",
			"shared cache: Capacity misses",
			"shared memory bus: Accesses"))


