#
# baumann.R, 27 Aug 19
# Data from:
# Hardware is the new software
# Andrew Baumann
#
# Unicode data from: Unicode article on Wikipedia
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG word documentation unicode letters


source("ESEUR_config.r")


pal_col=rainbow(2)

intel=read.csv(paste0(ESEUR_dir, "ecosystems/baumann.csv.xz"), as.is=TRUE)
unicode=read.csv(paste0(ESEUR_dir, "ecosystems/unicode.csv.xz"), as.is=TRUE)

# Word counts were obtained by running pdftotext and wc -w
# over old PDF files of the arch manuals.
intel$date=as.Date(paste0("01-", intel$Date), format="%d-%b-%y")

unicode$date=as.Date(paste0("01 ", unicode$Date), format="%d %B %Y")

plot(intel$date, intel$words/1e3, log="y", col=pal_col[1],
	xlim=range(c(intel$date, unicode$date)), ylim=range(c(intel$words, unicode$Letters))/1e3,
	xlab="Date", ylab="Items (thousand)\n")

points(unicode$date, unicode$Letters/1e3, col=pal_col[2])

legend(x="bottomright", legend=c("Words in Intel x86 manual", "Code-points in Unicode"), bty="n", fill=pal_col, cex=1.2)

