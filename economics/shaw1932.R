#
# shaw1932.R, 18 May 19
# Data from:
# A Comparison of Individuals and Small Groups in the Rational Solution of Complex Problems
# Marjorie E. Shaw
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG

source("ESEUR_config.r")


sh=read.csv(paste0(ESEUR_dir, "economics/shaw1932b.csv.xz"), as.is=TRUE)

ind=subset(sh, Indiv == "Y")

grp=subset(sh, Indiv == "N")

