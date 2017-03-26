#
# 978052-fixed-price.R, 27 Feb 17
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

pal_col=rainbow(2)

fp=read.csv(paste0(ESEUR_dir, "projects/978052-fixed-price.csv.xz"), as.is=TRUE)

loss=subset(fp, Profit < 0)
profit=subset(fp, Profit >= 0)

plot(profit$Size, profit$Profit, log="x", col=pal_col[2],
	ylim=range(fp$Profit),
	xlab="Project size ($)", ylab="Profit/Loss (%)")

points(loss$Size, loss$Profit, col=pal_col[1])

