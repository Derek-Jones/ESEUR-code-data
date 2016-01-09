#
# ff-src-version.R, 24 Jul 13
#
# R code for book "Empirical Software Engineering using R"
# Derek M. Jones, http://shape-of-code.coding-guidelines.com
#
# Uses data from:
# After-Life Vulnerabilities: A Study on Firefox Evolution, its Vulnerabilities, and Fixes
# by Fabio Massacci and Stephen Neuhaud and Viet Hung Nguyen
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")



src_version=read.csv(paste0(ESEUR_dir, "faults/milk-wine/ff-src-version.csv.xz"), row.names=1, as.is=TRUE)

brew_col=rainbow_hcl(6)

barplot(as.matrix(src_version), ylab="MLOC", col=brew_col,
	xlab="Firefox version")

