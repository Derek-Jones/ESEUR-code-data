#
# accu-exp-wr.R, 20 Dec 15
#
# Data from:
#
# ACCU experiments 2003-2007
# Derek M. Jones
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


dev=read.csv(paste0(ESEUR_dir, "developers/accu-exp-wr.csv.xz"), as.is=TRUE)

pal_col=rainbow(3)

plot(dev$read, dev$written)
plot(jitter(dev$experience), jitter(dev$written))

wr_mod=glm(written ~ experience, data=dev)

x_vals=seq(1, 30)
wr_pred=predict(wr_mod, data.frame(experience=x_vals))
lines(x_vals, wr_pred)

lines(loess.smooth(dev$experience, dev$written, span=0.5, family="gaussian"), col="green")

