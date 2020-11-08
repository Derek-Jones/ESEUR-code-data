#
# 2017015pap.R, 22 Oct 20
# Data from:
# {ICT} Prices and {ICT} Services: {What} do they tell us about Productivity and Technology?
# David Byrne and Carol Corrado
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG economics_software software_GDP software_product-sales

source("ESEUR_config.r")


pal_col=rainbow(3)


pap=read.csv(paste0(ESEUR_dir, "economics/2017015pap.csv.xz"), as.is=TRUE)

# Column values
# Software.products.R.D
# Manufacturing.ICT.only = Semiconductors+Computers+Communications.equipment
# Services = Software.publishing+Computer.systems.design...related+Telecom+Data.processing...related
# Percentage = 100*Value / GDP

plot(pap$Year, pap$Software.products.software.investment, type="l", col=pal_col[1],
	yaxs="i",
	xlab="Year", ylab="Percentage GDP\n")

lines(pap$Year, pap$ICT.manufacturing, col=pal_col[2])
lines(pap$Year, pap$ICT.services, col=pal_col[3])

legend(x="topleft", legend=c("Software products", "ICT manufacturing", "ICT services"), bty="n", fill=pal_col, cex=1.2)

