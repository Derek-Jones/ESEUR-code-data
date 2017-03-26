#
# Facebook10K12-15.R, 26 Mar 17
# Data from:
# Facebook Inc. 2013 Form 10-K, Facebook Inc. 2015 Form 10-K
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)


fb=read.csv(paste0(ESEUR_dir, "economics/Facebook10K12-15.csv.xz"), as.is=TRUE)
fb$Date=as.Date(fb$Date, format="%Y-%m-%d")

plot(fb$Date, fb$Total.revenue/fb$MAU, type="l", col=pal_col[1],
	ylim=c(0.5, 3.5),
	xlab="Quarters", ylab="Dollars\n")

lines(fb$Date, fb$Total.costs.and.expenses/fb$MAU, col=pal_col[2])

legend(x="topleft", legend=c("ARPU", "Cost of revenue per user"), bty="n", fill=pal_col, cex=1.2)

