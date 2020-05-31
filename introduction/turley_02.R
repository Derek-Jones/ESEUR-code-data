#
# turley_02.R, 22 May 20
# Data from:
# Jim Turley
# Embedded Processors
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG processor_sales


source("ESEUR_config.r")


pal_col=rainbow(4)

proc_sales=read.csv(paste0(ESEUR_dir, "introduction/turley_02.csv.xz"), as.is=TRUE)

proc_sales$date=as.Date(proc_sales$date, format="%d/%m/%Y")

plot(proc_sales$date, proc_sales$bit.8/1000, col=pal_col[1],
	xaxs="i", yaxs="i",
	ylim=c(0, max(proc_sales$bit.8/1000)),
	xlab="Date", ylab="Sales (millions)\n")

points(proc_sales$date, proc_sales$bit.4/1000, col=pal_col[2])
points(proc_sales$date, proc_sales$bit.16/1000, col=pal_col[3])
points(proc_sales$date, proc_sales$bit.32/1000, col=pal_col[4])

legend(x="topleft", legend=c("8-bit", "4-bit", "16-bit", "32-bit"),
		bty="n", fill=pal_col, cex=1.2)

