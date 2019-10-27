#
# MemDiskPrice-xl95.R, 10 Feb 18
# Data from:
# www.jcmit.com
# copyright 2000, 2004, 2007 John C. McCallum
# e5a4abf7b6834e... data from:
# Steven J. Davis and Jack MacCrisken and Kevin M. Murphy
# Economic Perspectives on Software Design: {PC} Operating Systems and Platforms
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG storage_cost disc_cost floppy_cost flash_cost DVD_cost


source("ESEUR_config.r")


pal_col=rainbow(5)

mag=read.csv(paste0(ESEUR_dir, "hardware/MemDiskPrice-mag.csv.xz"), as.is=TRUE)
flash=read.csv(paste0(ESEUR_dir, "hardware/MemDiskPrice-flash.csv.xz"), as.is=TRUE)
e5=read.csv(paste0(ESEUR_dir, "hardware/e5a4abf7b6834e_second-store.csv.xz"), as.is=TRUE)
e5$date=seq(1983, 2001, by=0.5) # Off by a month or two in places

hd=subset(mag, Type != "floppy")
floppy=subset(mag, Type == "floppy")

plot(hd$date, hd$Cost.US./hd$Size.MBytes, log="y", col=pal_col[1],
	xlab="Date", ylab="Dollars per MB\n")

points(floppy$date, floppy$Cost.US./floppy$Size.MBytes, col=pal_col[2])

points(e5$date, e5$f5.25.360K/0.36, col=pal_col[2])
points(e5$date, e5$f5.25.1.2MB/1.2, col=pal_col[2])
points(e5$date, e5$f3.5.1.44MB/1.44, col=pal_col[2])

points(flash$date, flash$Cost.US./flash$Size.MBytes, col=pal_col[4])

points(e5$date, e5$CD.ROM.650MB/650, col=pal_col[3])
points(e5$date, e5$DVD.ROM.4.7GB/4.7e+3, col=pal_col[5])

legend(x="bottomleft", legend=c("Hard disc", "Floppy drive (various capacities)", "CD drive", "Flash memory", "DVD drive"), bty="n", fill=pal_col, cex=1.2)

