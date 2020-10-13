#
# adams.R, 29 Aug 20
# Data from:
# Optimizing Preventive Service of Software Products
# Edward N. Adams
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG product_usage product_fault fault_usage-time

source("ESEUR_config.r")


library("reshape2")


pal_col=rainbow(9)


# Reported faults in each product usage bin is a percentage of total,
# i.e., it is a composite type.
# Fitting a regression model, other than composite regression, does
# not make any sense.
adams=read.csv(paste0(ESEUR_dir, "reliability/adams84.csv.xz"), as.is=TRUE)
adams_l=melt(adams, "P1", variable.name="product", value.name="defect_p")
adams_l=subset(adams_l, defect_p != 0)

adams_l$l_P1=log(adams_l$P1)

plot(adams_l$P1, adams_l$defect_p, log="xy", col=pal_col[adams_l$product],
	xlab="Product usage time (months)", ylab="Reported faults (percentage)\n")


