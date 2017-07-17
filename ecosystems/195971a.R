#
# 195971a.R, 26 May 17
# Data from:
# Multiyear Leasing And Government-Wide Purchasing Of Automatic Data Processing Equipment Should Result In Significant Savings
# Comptroller General of the United States
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)


rent_pur=read.csv(paste0(ESEUR_dir, "ecosystems/195971a.csv.xz"), as.is=TRUE)

plot(rent_pur$Year, rent_pur$Purchased, type="l", col=pal_col[1],
	xlab="Year", ylab="Systems\n")
lines(rent_pur$Year, rent_pur$Rented, col=pal_col[2])

legend(x="topleft", legend=c("Purchased", "Rented"), bty="n", fill=pal_col, cex=1.2)

