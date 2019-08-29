#
# 195971a.R, 21 Aug 19
# Data from:
# Multiyear Leasing And Government-Wide Purchasing Of Automatic Data Processing Equipment Should Result In Significant Savings
# Comptroller General of the United States
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG government computer_purchase computer_rent


source("ESEUR_config.r")


pal_col=rainbow(2)


rent_pur=read.csv(paste0(ESEUR_dir, "ecosystems/195971a.csv.xz"), as.is=TRUE)

plot(rent_pur$Year, rent_pur$Purchased, type="b", col=pal_col[1],
	xlab="Year", ylab="Systems\n")
lines(rent_pur$Year, rent_pur$Rented, type="b", col=pal_col[2])

legend(x="topleft", legend=c("Purchased", "Rented"), bty="n", fill=pal_col, cex=1.2)

