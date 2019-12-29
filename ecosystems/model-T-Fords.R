#
# model-T-Fords.R, 14 Dec 19
# Data from:
# From the {American} System to Mass Production 1800-1932: {The} Development of Manufacturing Technology in the {United States}
# David A. Hounshell
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG sales_Model-T Model-T_production

source("ESEUR_config.r")


mtf=read.csv(paste0(ESEUR_dir, "ecosystems/model-T-Fords.csv.xz"), as.is=TRUE)

plot(mtf$Year, mtf$Retail.price, col=pal_col[1],
	xlab="Year", ylab="Retail price ($)\n")

par(new=TRUE)

plot(mtf$Year, mtf$Sales, log="y", col=pal_col[2],
        bty="n", xaxt="n", yaxt="n",
        xlab="", ylab="")

axis(4, at=c(5e3, 1e4, 5e4, 1e5, 5e5, 1e6), col=pal_col[2])

mtext("Model-T sales", side=4, las=0, at=5e4, padj=5, cex=0.8)

