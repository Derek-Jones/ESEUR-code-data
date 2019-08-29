#
# GovMachineHistComputer.R, 26 Aug 19
# Data from:
# The Government Machine {A} Revolutionary History of the Computer
# Jon Agar
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG government hardware card office-equipement

source("ESEUR_config.r")


pal_col=rainbow(4)


cards=read.csv(paste0(ESEUR_dir, "ecosystems/GovMachineHistComputer.csv.xz"), as.is=TRUE)

plot(cards$Financial_year, cards$Typewriters_duplicators/1e3, log="y", type="b", col=pal_col[1],
	ylim=c(7e3, 1e6)/1e3,
	xlab="Year", ylab="Expenditure (£thousand)\n")

points(cards$Financial_year, cards$Other/1e3, type="b", col=pal_col[2])
points(cards$Financial_year, cards$Tabulators_rent/1e3, type="b", col=pal_col[3])
points(cards$Financial_year, cards$Cards/1e3, type="b", col=pal_col[4])

legend(x="topleft", legend=c("Typewriters/duplicators", "Other", "Tabulator rental", "Cards"), bty="n", fill=pal_col, cex=1.2)

