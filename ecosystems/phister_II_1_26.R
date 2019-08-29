#
# phister_II_1_26.R, 21 Aug 19
# Data from:
# Data Processing Technology and Economics
# Montgomery {Phister, Jr.}
# Table II.1.26, II.1.20 and II.1.26a, II.1.20a
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG service_sales systems_sales

source("ESEUR_config.r")


pal_col=rainbow(2)

sr=read.csv(paste0(ESEUR_dir, "ecosystems/phister_II_1_26.csv.xz"), as.is=TRUE)

plot(sr$Year, sr$Total.Systems, log="y", type="b", col=pal_col[1],
	ylim=c(min(sr$Service.Revenue), max(sr$Total.Systems)),
	xlab="Year", ylab="Total revenue ($billion)\n")
lines(sr$Year, sr$Service.Revenue, type="b", col=pal_col[2])

legend(x="bottomright", legend=c("Systems sales", "Service revenue"), bty="n", fill=pal_col, cex=1.2)

