#
# turley_02.R, 25 Feb 17
#
# Data from:
# Jim Turley
# Embedded Processors
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


proc_sales=read.csv(paste0(ESEUR_dir, "introduction/turley_02.csv.xz"), as.is=TRUE)

proc_sales$date=as.Date(proc_sales$date, format="%d/%m/%Y")

pal_col=rainbow(4)

plot(proc_sales$date, proc_sales$bit.8/1000, col=pal_col[1],
	ylim=c(0, max(proc_sales$bit.8/1000)),
	xlab="Date", ylab="Sales (millions)\n")

points(proc_sales$date, proc_sales$bit.4/1000, col=pal_col[2])
points(proc_sales$date, proc_sales$bit.16/1000, col=pal_col[3])
points(proc_sales$date, proc_sales$bit.32/1000, col=pal_col[4])

legend(x="topleft", legend=c("8-bit", "4-bit", "16-bit", "32-bit"),
		bty="n", fill=pal_col, cex=1.2)

