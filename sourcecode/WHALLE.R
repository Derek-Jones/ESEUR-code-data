#
# WHALLE.R, 19 Feb 20
# Data from:
# Relating Static and Dynamic Machine Code Measurements
# Jack W. Davidson and John R. Rabung and David B. Whalley
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG C call_dynamic-count call_static-count compile_call


source("ESEUR_config.r")


pal_col=rainbow(2)


wh=read.csv(paste0(ESEUR_dir, "sourcecode/WHALLE.csv.xz"), as.is=TRUE)

plot(wh$Static, wh$Dynamic, type="n",
	xlab="Static calls (percent)", ylab="Dynamic calls (percent)\n")

text(wh$Static, wh$Dynamic, labels=wh$CPU, col=pal_col[1])

x_bounds=seq(5, 12, by=0.1)

sd_mod=glm(Dynamic ~ Static, data=wh)
# summary(sd_mod)

pred=predict(sd_mod, newdata=data.frame(Static=x_bounds))

lines(x_bounds, pred, col=pal_col[2])


