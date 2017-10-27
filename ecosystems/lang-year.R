#
# lang-year.R, 20 Oct 17
# Data from:
# Online Historical Encyclopedia of Programming Languages
# Diarmuid J. Pigott and Bruce M. Axtens
# http://hopl.info
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


ly=read.csv(paste0(ESEUR_dir, "ecosystems/lang-year.csv.xz"), as.is=TRUE)

plot(ly$Year, ly$Languages, col=point_col,
	xlim=c(1949, 2000), # Post 2000 effort seems low
	xlab="Year", ylab="New languages\n")

