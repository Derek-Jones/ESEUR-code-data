#
# accu-exp-wr.R, 23 Nov 17
# Data from:
# ACCU experiments 2003-2007
# Derek M. Jones
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


dev=read.csv(paste0(ESEUR_dir, "developers/accu-exp-wr.csv.xz"), as.is=TRUE)
dev$k_written=dev$written/1e3

pal_col=rainbow(3)

# plot(dev$read, dev$k_written), col=point_col,
# 	xlab="Read (lines)", ylab="Written (thousand lines)")
plot(jitter(dev$experience), jitter(dev$k_written), col=point_col,
	xlab="Experiences (years)", ylab="Written (thousand lines)\n")

wr_mod=glm(k_written ~ experience+I(experience^2), data=dev)

x_vals=seq(1, 30)
wr_pred=predict(wr_mod, data.frame(experience=x_vals))
lines(x_vals, wr_pred, col=pal_col[1])

lines(loess.smooth(dev$experience, dev$k_written, span=0.5, family="gaussian"), col=pal_col[2])

wr_nl_mod=nls(k_written ~ a-b*exp(-c*experience),
#		trace=TRUE,
		start=list(a=13e4, b=13e3, c=0.4),
		data=dev)
wr_pred=predict(wr_nl_mod, data.frame(experience=x_vals))
lines(x_vals, wr_pred, col=pal_col[3])


legend(x="bottomright", legend=c("Quadratic", "Loess", "Exponential"), bty="n", fill=pal_col, cex=1.2)

# library("nlme")

# # gnls does not automatically handle NAs
# clean_dev=subset(dev, !is.na(k_written) & !is.na(experience))

# # Does not converge, even when very close' values plugged in
# wr_nl_mod=gnls(k_written ~ a-b*exp(-c*experience),
# 		verbose=TRUE,
# 		start=list(a=130000, b=110000, c=0.1),
# 		data=clean_dev)
# wr_pred=predict(wr_nl_mod, data.frame(experience=x_vals))
# lines(x_vals, wr_pred, col=pal_col[3])


