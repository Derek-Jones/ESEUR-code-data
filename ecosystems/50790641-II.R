#
# 50790641-II.R,  3 Apr 17
# Data from:
# Employment of trained computer personnel\textemdash {A} quantitative survey
# Bruce Gilchrist and Richard E. Weber
# Table II
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


ADP=read.csv(paste0(ESEUR_dir, "ecosystems/50790641-II.csv.xz"), as.is=TRUE)

pal_col=rainbow(ncol(ADP)-1)


plot(0, type="n", log="y",
	xaxs="i",
	xlim=c(1967, 1970), ylim=c(500, max(ADP$Total)),
	xlab="Year", ylab="Employed\n")

t=sapply(2:ncol(ADP), function(X) lines(ADP$Year, ADP[, X], col=pal_col[X-1]))

job_title=colnames(ADP)

legend(x="bottom", legend=job_title[-1], bty="n", fill=pal_col, cex=1.2)

