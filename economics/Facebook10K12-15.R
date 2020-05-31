#
# Facebook10K12-15.R, 22 May 20
# Data from:
# Facebook Inc. 2013 Form 10-K, Facebook Inc. 2015 Form 10-K
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Facebook_expenses ARPU MAU


source("ESEUR_config.r")


pal_col=rainbow(2)


fb=read.csv(paste0(ESEUR_dir, "economics/Facebook10K12-15.csv.xz"), as.is=TRUE)
fb$Date=as.Date(fb$Date, format="%Y-%m-%d")

plot(fb$Date, fb$Total.revenue/fb$MAU, type="l", col=pal_col[1],
	xaxs="i", yaxs="i",
	xlim=c(as.Date("2012-01-01"), as.Date("2016-01-01")), ylim=c(0.5, 3.5),
	xlab="Quarters", ylab="Dollars\n")

lines(fb$Date, fb$Total.costs.and.expenses/fb$MAU, col=pal_col[2])

legend(x="topleft", legend=c("ARPU", "Cost of revenue per user"), bty="n", fill=pal_col, cex=1.2)

