#
# mazzucat.R, 15 Nov 17
# Data from:
# Risk, Variety and Volatility in the {PC} Industry: {\it New} Economy or {\it Early} Life-Cycle?
# Mariana Mazzucato
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG company_startup company_fail car PC


source("ESEUR_config.r")


pal_col=rainbow(2)

maz=read.csv(paste0(ESEUR_dir, "ecosystems/mazzucat.csv.xz"), as.is=TRUE)

pcs=subset(maz, Industry == "PC")
autos=subset(maz, Industry == "Auto")

pcs$companies=cumsum(pcs$Entry)-cumsum(pcs$Exit)
autos$companies=cumsum(autos$Entry)-cumsum(autos$Exit)

plot(pcs$companies, type="b", col=pal_col[1],
	xlim=c(1, 33),
	xlab="Years since introduction", ylab="Companies\n")
lines(autos$companies, type="b", col=pal_col[2])

legend(x="topleft", legend=c("PC companies", "Automobile companies"), bty="n", fill=pal_col, cex=1.2)


