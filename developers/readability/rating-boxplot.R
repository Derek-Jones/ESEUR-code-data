#
# rating-boxplot.R,  5 Jan 16
#
# Data from:
# Learning a Metric for Code Readability
# Raymond P. L. Buse and Westley R. Weimer
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

all_snip_data=read.csv(paste0(ESEUR_dir, "developers/readability/readability-tse.csv.xz"),
                   header=FALSE, as.is=TRUE)

cs2_subj=all_snip_data[substr(all_snip_data[, 2], 1, 3) =="cs2", ][, -2:-1]

boxplot(cs2_subj[,1:50], col=c("light blue", "pink"))

