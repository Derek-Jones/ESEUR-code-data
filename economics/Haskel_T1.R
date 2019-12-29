#
# Haskel_T1.R,  6 Dec 19
# Data from:
# Estimating {UK} investment in intangible assets and Intellectual Property Rights
# Peter Goodridge and Jonathan Haskel and Gavin Wallis
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG UK investment intangible

source("ESEUR_config.r")


pal_col=rainbow(5)


econ=read.csv(paste0(ESEUR_dir, "economics/Haskel_T1.csv.xz"), as.is=TRUE)

plot(econ$Year, econ$All.intangibles, type="l", col=pal_col[1],
	yaxs="i",
	ylim=c(0, 140),
	xlab="Year", ylab="£ Billion\n")

lines(econ$Year, econ$All.tangibles, col=pal_col[2])

lines(econ$Year, econ$Economic.Competencies, col=pal_col[3])
lines(econ$Year, econ$Innovative.Property, col=pal_col[4])
lines(econ$Year, econ$Own.account.Software+econ$Purchased.Software, col=pal_col[5])

legend(x="topleft", legend=c("Economic competencies", "Innovative property", "Software"), bty="n", fill=pal_col[3:5], cex=1.2)

text(2005, 115, "Intangibles", cex=1.2, pos=4)
text(2005, 102, "Tangibles", cex=1.2, pos=4)

