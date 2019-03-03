#
# Rubin-recall.R, 31 Jan 19
# Data from:
# The Precise Time Course of Retention
# David C. Rubin and Sean Hinton and Amy Wenzel
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment human memory

source("ESEUR_config.r")


library("gnm")

pal_col=rainbow(3)

recall=read.csv(paste0(ESEUR_dir, "developers/Rubin-recall.csv.xz"), as.is=TRUE)

acc=subset(recall, measured=="accuracy")

plot(acc$lag, acc$matched, log="y", col=pal_col[1],
	xaxs="i",
	xlim=c(-3, 100),
	xlab="Lag (words)", ylab="Fraction correct\n")

acc_mod=gnm(matched ~ instances(Mult(1, Exp(lag)), 2)-1,
                data=acc, verbose=FALSE,
                start=c(1.0, -0.6, 0.3, -0.1))

exp_coef=as.numeric(coef(acc_mod))

lines(acc$lag, exp_coef[1]*exp(exp_coef[2]*acc$lag), col=pal_col[2])
lines(acc$lag, exp_coef[3]*exp(exp_coef[4]*acc$lag), col=pal_col[3])
t=predict(acc_mod)
lines(acc$lag, t, col=pal_col[1])


