#
# pdf-per-year.R, 26 Dec 15
#
# Data from:
# Formats over Time: Exploring UK Web History
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

library("plyr")


plot_pdf=function(df)
{
lines(df$year, df$occurrences, col=pal_col[as.numeric(df$version[1])])
}


pdf_occur=read.csv(paste0(ESEUR_dir, "ecosystem/pdf-per-year.csv.xz"), as.is=TRUE)

pdf_occur=pdf_occur[order(pdf_occur$year), ]
pdf_occur$version=as.factor(pdf_occur$version)

pal_col=rainbow(length(unique(pdf_occur$version)))

plot(1, type="n", log="y",
	xlim=c(1996, 2010), ylim=c(1e1, 2e6),
	xlab="Year", ylab="Occurrences\n")
d_ply(pdf_occur, .(version), plot_pdf)

legend(x="bottomright", legend=unique(pdf_occur$version),
				bty="n", fill=pal_col, cex=1.2)

