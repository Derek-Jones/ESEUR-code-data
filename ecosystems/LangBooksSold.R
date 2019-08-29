#
# LangBooksSold.R, 12 Aug 19
# Data from:
# Mike Hendrickson
# 2010 State of the Computer Book Market
# Data extracted from figure.
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG book language sales


source("ESEUR_config.r")


library("plyr")


plot_lang=function(df)
{
lines(df$Year, df$Sales, col=df$col_str)
}


lbs=read.csv(paste0(ESEUR_dir, "ecosystems/LangBooksSold.csv.xz"), as.is=TRUE)

u_lang=unique(lbs$Language)

pal_col=rainbow(length(u_lang))
lbs$col_str=mapvalues(lbs$Language, u_lang, pal_col)

plot(1, type="n",
	xaxs="i", yaxs="i",
	xlim=range(lbs$Year), ylim=range(lbs$Sales),
	xlab="Year", ylab="Sales\n")

d_ply(lbs, .(Language), plot_lang)

legend(x="topright", legend=u_lang, bty="n", fill=pal_col, cex=1.2)


