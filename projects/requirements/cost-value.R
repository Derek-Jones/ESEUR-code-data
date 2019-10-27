#
# cost-value.R,  9 Oct 19
#
# Data from:
# A Cost-Value Approach for Prioritizing Requirements
# Joachim Karlsson and Kevin Ryan
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG


source("ESEUR_config.r")


pal_col=rainbow(3)

# All values are percentages.
# None of the columns sum to 100%
# cost,value,project
bench=read.csv(paste0(ESEUR_dir, "projects/requirements/cost-value.csv.xz"), as.is=TRUE)

RAN=subset(bench, project == "RAN")
PMR=subset(bench, project == "PMR")

plot(RAN$cost, RAN$value, col=pal_col[1],
	xlab="Cost", ylab="Value")
points(PMR$cost, PMR$value, col=pal_col[3])

lines(c(0, 10), c(0,20), col=pal_col[2]) # One cost/benefit choice

cor.test(rank(RAN$value), rank(RAN$cost), method="spearman")
cor.test(rank(PMR$value), rank(PMR$cost), method="spearman")

order(RAN$value/RAN$cost, decreasing=TRUE)

