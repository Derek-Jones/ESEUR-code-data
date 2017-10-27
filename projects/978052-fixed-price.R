#
# 978052-fixed-price.R, 30 Sep 17
# Data from:
# IT Project Estimation: {A} Practical Guide to the Costing of Software
# Paul Coombs
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)

fp=read.csv(paste0(ESEUR_dir, "projects/978052-fixed-price.csv.xz"), as.is=TRUE)

loss=subset(fp, Profit < 0)
profit=subset(fp, Profit >= 0)

plot(profit$Size/1e3, profit$Profit, log="x", col=pal_col[2],
	ylim=range(fp$Profit),
	xlab="Project size ($thousand)", ylab="Profit/Loss (%)\n")

points(loss$Size/1e3, loss$Profit, col=pal_col[1])

