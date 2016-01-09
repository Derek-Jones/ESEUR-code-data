#
# gcc-trans_prob.R, 29 Aug 15
#
# Data from:
#
# Empirical Assessment of Architecture-Based Reliability of Open-Source Software
# Ranganath Perugupalli
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("ascii")


# Table 5.1
gcc_trans_count=read.csv(paste0(ESEUR_dir, "reliability/gcc-reliability-calls.csv.xz"),
		header=FALSE, as.is=TRUE)
err_cnt=read.csv(paste0(ESEUR_dir, "reliability/gcc-reliability-errors.csv.xz"), as.is=TRUE)


# Convert element to a row probability
gcc_trans_prob=gcc_trans_count/rowSums(gcc_trans_count)

print(ascii(gcc_trans_prob, include.rownames = FALSE, include.colnames = FALSE,
		format="e", digits=1))

