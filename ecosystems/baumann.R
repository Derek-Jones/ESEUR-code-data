#
# baumann.R, 25 Jun 17
# Data from:
# Hardware is the new software
#
# Unicode data from: emergent.unpythonic.net/01360162755
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)

counts=read.csv(paste0(ESEUR_dir, "ecosystems/baumann.csv.xz"), as.is=TRUE)

# Word counts were obtained by running pdftotext and wc -w
# over old PDF files of the arch manuals.
intel=subset(counts, source == "Intel")
intel$date=as.Date(paste0("01-", intel$date), format="%d-%b-%y")

unicode=subset(counts, source == "Unicode")
unicode$date=as.Date(unicode$date, format="%d/%m/%y")

plot(intel$date, intel$words, log="y", col=pal_col[1],
	xlim=range(c(intel$date, unicode$date)), ylim=range(counts$words),
	xlab="Date", ylab="Items\n")

points(unicode$date, unicode$words, col=pal_col[2])

legend(x="bottomright", legend=c("Words in Intel x86 manual", "Code-points in Unicode"), bty="n", fill=pal_col, cex=1.2)

