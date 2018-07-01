#
# GovMachineHistComputer.R, 19 May 18
# Data from:
# The Government Machine {A} Revolutionary History of the Computer
# Jon Agar
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# TAG government hardware card office-equipement

source("ESEUR_config.r")


pal_col=rainbow(4)


cards=read.csv(paste0(ESEUR_dir, "ecosystems/GovMachineHistComputer.csv.xz"), as.is=TRUE)

plot(cards$Financial_year, cards$Typewriters_duplicators, log="y", col=pal_col[1],
	ylim=c(9e3, 1e6),
	xlab="Year", ylab="Expenditure (in #)\n")

points(cards$Financial_year, cards$Other, col=pal_col[2])
points(cards$Financial_year, cards$Tabulators_rent, col=pal_col[3])
points(cards$Financial_year, cards$Cards, col=pal_col[4])

legend(x="topleft", legend=c("Typewriters/duplicators", "Other", "Tabulator rental", "Cards"), bty="n", fill=pal_col, cex=1.2)

