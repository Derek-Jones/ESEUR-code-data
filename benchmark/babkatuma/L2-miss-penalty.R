#
# L2-miss-penalty.R,  5 Apr 20
#
# Data from:
# Investigating Cache Parameters of x86 Family Processors
# Vlastimil Babka and Petr T{\ra}ma
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_hardware x86_cache


source("ESEUR_config.r")


library("plyr")

pal_col=rainbow(3)


plot_cache_cpu=function(file_str, stride, col_str)
{
babka=read.table(paste0(ESEUR_dir, "benchmark/babkatuma/", file_str), as.is=TRUE, header=TRUE)
babka$CPU_Clocks=babka$CPU_Clocks / (stride*1000)

cc_mean=ddply(babka, .(cache_line_offset), function(df) mean(df$CPU_Clocks))
cc_sd=ddply(babka, .(cache_line_offset), function(df) sd(df$CPU_Clocks))

lines(cc_mean$cache_line_offset, cc_mean$V1+cc_sd$V1, col="grey")
lines(cc_mean$cache_line_offset, cc_mean$V1-cc_sd$V1, col="grey")
lines(cc_mean$cache_line_offset, cc_mean$V1, col=col_str)

text(max(cc_mean$cache_line_offset)/2, max(cc_mean$V1)+4, stride,
		col="grey", cex=1.3)
}


xbounds=c(0, 4000)
ybounds=c(220, 300)
plot(0, type="n",
	xaxs="i",
	xlim=xbounds, ylim=ybounds,
	xlab="Byte offset within page", ylab="Access time\n")

plot_cache_cpu("cache_line_offset-128,32,1000,64,262144,0,0,1,64-.xz",
		 32, pal_col[1])
plot_cache_cpu("cache_line_offset-128,64,1000,64,262144,0,0,1,64-.xz", 64, pal_col[2])
plot_cache_cpu("cache_line_offset-128,128,1000,64,262144,0,0,1,64-.xz", 128, pal_col[3])


