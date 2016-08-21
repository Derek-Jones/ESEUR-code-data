#
# MemDiskPrice-xl95.R, 12 Aug 16
# Data from:
# www.jcmit.com
# copyright 2000, 2004, 2007 John C. McCallum
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(3)

mag=read.csv(paste0(ESEUR_dir, "hardware/MemDiskPrice-mag.csv.xz"), as.is=TRUE)
flash=read.csv(paste0(ESEUR_dir, "hardware/MemDiskPrice-flash.csv.xz"), as.is=TRUE)

hd=subset(mag, Type != "floppy")
floppy=subset(mag, Type == "floppy")

plot(hd$date, hd$Cost.US./hd$Size.MBytes, log="y", col=pal_col[1],
	xlab="Date", ylab="Dollars per MB\n")

points(floppy$date, floppy$Cost.US./floppy$Size.MBytes, col=pal_col[2])

points(flash$date, flash$Cost.US./flash$Size.MBytes, col=pal_col[3])

legend(x="bottomleft", legend=c("Hard disc", "Floppy disc", "Flash memory"), bty="n", fill=pal_col, cex=1.2)

