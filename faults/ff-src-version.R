#
# ff-src-version.R, 21 Nov 19
#
# Uses data from:
# After-Life Vulnerabilities: A Study on Firefox Evolution, its Vulnerabilities, and Fixes
# Fabio Massacci and Stephen Neuhaud and Viet Hung Nguyen
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG firefox_version-source source-code_version


source("ESEUR_config.r")


src_version=read.csv(paste0(ESEUR_dir, "faults/ff-src-version.csv.xz"), row.names=1, as.is=TRUE)

brew_col=rainbow_hcl(6)

barplot(as.matrix(src_version), ylab="MLOC", col=brew_col,
	xlab="Firefox version")

