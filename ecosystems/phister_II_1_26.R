#
# phister_II_1_26.R, 31 Jan 18
# Data from:
# Data Processing Technology and Economics
# Montgomery {Phister, Jr.}
# Table II.1.26, II.1.20 and II.1.26a, II.1.20a
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)

sr=read.csv(paste0(ESEUR_dir, "ecosystems/phister_II_1_26.csv.xz"), as.is=TRUE)

plot(sr$Year, sr$Total.Systems, log="y", col=pal_col[1],
	ylim=c(min(sr$Service.Revenue), max(sr$Total.Systems)),
	xlab="Year", ylab="Total revenue ($billion)\n")
points(sr$Year, sr$Service.Revenue, log="y", col=pal_col[2])

legend(x="bottomright", legend=c("Systems revenue", "Service revenue"), bty="n", fill=pal_col, cex=1.2)

