#
# lang-year.R, 27 May 20
# Data from:
# Online Historical Encyclopedia of Programming Languages
# Diarmuid J. Pigott and Bruce M. Axtens
# http://hopl.info
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG programming-language_new


source("ESEUR_config.r")


ly=read.csv(paste0(ESEUR_dir, "ecosystems/lang-year.csv.xz"), as.is=TRUE)

plot(ly$Year, ly$Languages, type="l", col=point_col,
	xaxs="i", yaxs="i",
	# Post 2000 effort seems low
	xlim=c(1949, 2000), ylim=c(0, 320),
	xlab="Year", ylab="New languages\n")

