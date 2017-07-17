#
# file-format.R, 16 Mar 13
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


fmt=read.csv(paste0(ESEUR_dir, "ecosystem/file-type/fmts-cleaned.tsv.xz"), as.is=TRUE, sep="\t")

fmt$year=as.numeric(as.character(fmt$year))
fmt$count=as.numeric(as.character(fmt$count))

fmt=subset(fmt, !is.na(fmt$year))
fmt=subset(fmt, !is.na(fmt$count))

plot(table(fmt$count), ylim=c(0,100), xlim=c(1,10000))

