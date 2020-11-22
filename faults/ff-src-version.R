#
# ff-src-version.R,  2 Jun 20
#
# Uses data from:
# After-Life Vulnerabilities: A Study on Firefox Evolution, its Vulnerabilities, and Fixes
# Fabio Massacci and Stephen Neuhaud and Viet Hung Nguyen
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Firefox_version-source source-code_version Firefox_LOC


source("ESEUR_config.r")


src_version=read.csv(paste0(ESEUR_dir, "faults/ff-src-version.csv.xz"), row.names=1, as.is=TRUE)

pal_col=rainbow(ncol(src_version))


plot(1, type="n", log="y",
	xaxs="i", xaxt="n",
	xlim=c(1, 6.05), ylim=c(0.01, 5),
	xlab="Firefox version", ylab="MLOC\n")

axis(1, at=1:ncol(src_version), labels=names(src_version))

legend(x="bottomleft", legend=names(src_version), bty="n", fill=pal_col, cex=1.2)


tsv=t(src_version)

d=sapply(1:nrow(tsv), function (X) lines(tsv[, X], type="b", col=pal_col[X]))

