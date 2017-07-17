#
# software-sales.R, 12 Jul 17
# Data from:
# Data Processing Technology and Economics
# Montgomery Phister, Jr.
# Table II.1.25a
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)


phister=read.csv(paste0(ESEUR_dir, "ecosystems/phister_II_1_25a.csv.xz"), as.is=TRUE)

plot(phister$Year, phister$Total.Packages, type="l", col=pal_col[1], log="y",
	xlab="Year", ylab="Dollars (billion)\n")
lines(phister$Year, phister$Custom, col=pal_col[2])

legend(x="bottomright", legend=c("Packed software (total)", "Custom software"), bty="n", fill=pal_col, cex=1.2)

