#
# sales-cycle.R, 24 Apr 20
# Data from:
# The Cost of High-Powered Incentives: {Employee} Gaming in Enterprise Software Sales
# Ian Larkin
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG incentives sales_closed


source("ESEUR_config.r")

pal_col=rainbow(2)

sales=read.csv(paste0(ESEUR_dir, "economics/sales-cycle.csv.xz"), as.is=TRUE)

plot(sales$week, 100*sales$volume/sum(sales$volume), type="b", col=pal_col[1],
	yaxs="i",
	xlab="Week", ylab="Percentage\n")

lines(sales$week, sales$discount, type="b", col=pal_col[2])

legend(x="topleft", legend=c("Sales", "Discount"), bty="n", fill=pal_col, cex=1.2)

