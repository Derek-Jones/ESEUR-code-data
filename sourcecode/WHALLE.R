#
# WHALLE.R,  5 Apr 18
# Data from:
# Relating Static and Dynamic Machine Code Measurements
# Jack W. Davidson and John R. Rabung and David B. Whalley
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# RAg C call dynamic compile static


source("ESEUR_config.r")


wh=read.csv(paste0(ESEUR_dir, "sourcecode/WHALLE.csv.xz"), as.is=TRUE)

plot(wh$Static, wh$Dynamic, type="n",
	xlab="Static calls (percent)", ylab="Dynamic calls (percent)\n")

text(wh$Static, wh$Dynamic, labels=wh$CPU, col=point_col)

x_bounds=seq(5, 11, by=0.1)

sd_mod=glm(Dynamic ~ Static, data=wh)
pred=predict(sd_mod, newdata=data.frame(Static=x_bounds))

lines(x_bounds, pred, col="grey")


