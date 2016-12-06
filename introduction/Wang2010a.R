#
# Wang2010a.R, 16 Aug 16
# Data from:
# Chasing the Hottest {IT}: {Effects} of Information Technology Fashion on Organizations
# Ping Wang
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


product=read.csv(paste0(ESEUR_dir, "introduction/Wang2010a_Fig2.csv.xz"), as.is=TRUE)

pal_col=rainbow(ncol(product)-1)

plot(0, type="n",
	xlim=c(1987, 2003), ylim=c(0, 175),
	xlab="Date", ylab="Occurrences\n")

dummy=sapply(2:ncol(product), function(X)
			lines(product$Year, product[, X], col=pal_col[X-1]))

leg_names=colnames(product)
leg_names=gsub("\\.", " ", leg_names[-1])

legend(x="topleft", legend=leg_names, bty="n", fill=pal_col, cex=1.1)

