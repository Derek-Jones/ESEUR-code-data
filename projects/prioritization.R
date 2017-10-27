#
# prioritization.R, 16 Oct 17
#
# Data from:
# An industrial case study on distributed prioritisation in market-driven requirements engineering for packaged software
# Björn Regnell, Martin Höst, Johan Natt och Dag, Per Beremark, Thomas Hjelm
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library(plyr)

pal_col=rainbow(2)

high_level=read.csv(paste0(ESEUR_dir, "projects/high-level.csv.xz"), as.is=TRUE)
detailed=read.csv(paste0(ESEUR_dir, "projects/detailed.csv.xz"), as.is=TRUE)

# What is the correlation between the amount 'spent' on
# high level and corresponding detailed requirements?
# detailed$high_Req=substr(detailed$Req, 1, 1)
# 
# high_detailed=ddply(detailed, .(high_Req), function(df) colSums(df[, 2:11]))
# 
# hd1=subset(high_level, subset=Req %in% high_detailed$high_Req)
# hd2=subset(high_detailed, subset=high_Req %in% high_level$Req)
# 
# t=lapply(1:10, function(x) cor.test(hd1[, x+1], hd2[, x+1], method="spearman"))
# 
# q=lapply(t, function(X) X$estimate)
# 
# mean(unlist(q))

req_spend=high_level[, -1] # remove Requirements id
num_reqs=nrow(req_spend)

spend_per_req=rowSums(req_spend) / num_reqs

req_rank=order(spend_per_req, decreasing=TRUE)

# Calculate column sums with each prioritiser removed in turn
spend_minus_one=sapply(1:ncol(req_spend),
			function(X) rowSums(req_spend[, -c(1, X)]))
# Expand to same number of requirements
spend_minus_one=(num_reqs/(num_reqs-1))*spend_minus_one / (num_reqs-1)

# Standard deviation for when one prioritiser is omitted
req_spend_sd=apply(spend_minus_one, 1, sd)

plot(spend_per_req[req_rank], type="l", col=pal_col[1],
	xlab="Requirement", ylab="Allocated funds\n")
lines(spend_per_req[req_rank]+req_spend_sd[req_rank], col=pal_col[2])
lines(spend_per_req[req_rank]-req_spend_sd[req_rank], col=pal_col[2])


