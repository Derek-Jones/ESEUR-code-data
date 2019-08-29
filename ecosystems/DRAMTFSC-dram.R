#
# DRAMTFSC-dram.R, 28 Aug 19
# Data from:
# DRAMs as Model Organisms for Study of Technological Evolution
# Nadejda M. Victor and Jesse H. Ausubel
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG DRAM_shipped evolution_memory product_shipments


source("ESEUR_config.r")

library("plyr")


pal_col=rainbow(8)


yearly_bits=function(df)
{
return((df$ship4K*4*2^10+
	df$ship16K*16*2^10+
	df$ship64K*64*2^10+
	df$ship256K*256*2^10+
	df$ship1M*1*2^20+
	df$ship4M*4*2^20+
	df$ship16M*16*2^20+
	df$ship64M*64*2^20)*1e6)
}

plot_ship=function(ship, col_str)
{
lines(dram$Year, ship*1e6/(8*2^30), col=col_str)
}

dram=read.csv(paste0(ESEUR_dir, "ecosystems/DRAMTFSC-dram.csv.xz"), as.is=TRUE)

dram$WWbits=daply(dram, .(Year), yearly_bits)


plot(dram$Year, dram$WWbits/(8*2^30), log="y", col=point_col,
	xlab="Year", ylab="World-wide DRAM shipped (GB)\n")


plot_ship(dram$ship4K*4*2^10, pal_col[1])
plot_ship(dram$ship16K*16*2^10, pal_col[2])
plot_ship(dram$ship64K*64*2^10, pal_col[3])
plot_ship(dram$ship256K*256*2^10, pal_col[4])
plot_ship(dram$ship1M*1*2^20, pal_col[5])
plot_ship(dram$ship4M*4*2^20, pal_col[6])
plot_ship(dram$ship16M*16*2^20, pal_col[7])
plot_ship(dram$ship64M*64*2^20, pal_col[8])

legend(x="topleft", legend=c("4K", "16K", "64K", "256K", "1M", "4M", "16M", "64M"), bty="n", fill=pal_col, cex=1.2)

