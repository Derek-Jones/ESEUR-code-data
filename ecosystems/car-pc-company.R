#
# car-pc-company.R, 17 Nov 17
# Data from:
#
# Example from:
# Evidence-based Software Engineering using R
# Derek M. Jones
#
# TAG company car PC


source("ESEUR_config.r")


pal_col=rainbow(2)

pcs=read.csv(paste0(ESEUR_dir, "ecosystems/stavins1995.csv.xz"), as.is=TRUE)

start_year=min(pcs$Year)

plot(1+pcs$Year-start_year, pcs$Firm_Stock, type="b", col=pal_col[1],
	xlab="Years since introduction", ylab="Companies\n")

legend(x="topleft", legend=c("PC companies", "Automobile companies"), bty="n", fill=pal_col, cex=1.2)


