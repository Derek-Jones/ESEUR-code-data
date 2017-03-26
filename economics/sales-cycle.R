#
# sales-cycle.R, 21 Mar 17
# Data from:
# The Cost of High-Powered Incentives: {Employee} Gaming in Enterprise Software Sales
# Ian Larkin
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

pal_col=rainbow(2)

sales=read.csv(paste0(ESEUR_dir, "economics/sales-cycle.csv.xz"), as.is=TRUE)

plot(sales$week, 100*sales$volume/sum(sales$volume), type="b", col=pal_col[1],
	xlab="Week", ylab="Percentage")

lines(sales$week, sales$discount, type="b", col=pal_col[2])

legend(x="topleft", legend=c("Sales", "Discount"), bty="n", fill=pal_col, cex=1.2)

