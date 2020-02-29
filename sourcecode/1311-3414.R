#
# 1311-3414.R, 28 Feb 20
# Data from:
# Mining Software Repair Models for Reasoning on the Search Space of Automated Program Fixing
# Matias Martinez and Martin Monperrus
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Java source_evolution code_added code_deleted code_modified

source("ESEUR_config.r")


library("plyr")


sum_freq=function(df)
{
return(sum(df$frequency))
}


# BFP - bug fix patch
# SC - source change, e.g., 1-SC one AST source change
# LC - ???

db=read.csv(paste0(ESEUR_dir, "sourcecode/1311-3414.csv.xz"), as.is=TRUE)

db_all=subset(db, (name == "all") & !is.na(entity))

all_CTsum=ddply(db_all, .(CT), sum_freq)
all_ENsum=ddply(db_all, .(entity), sum_freq)
all_sum=ddply(db_all, .(CT, entity), sum_freq)

top10_all=tail(all_sum[order(all_sum$V1), ], n=10)

