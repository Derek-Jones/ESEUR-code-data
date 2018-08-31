#
# pani-exits.R, 13 Aug 18
# Data from:
# Loop Patterns in C Programs
# Thomas Pani
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG loop source C


source("ESEUR_config.r")


library("gnm")


plot_layout(2, 1)
pal_col=rainbow(3)


fit_exits=function(df, ex_1, ex_2)
{
plot(df$num, df$bound, log="y", col=pal_col[2],
	xlab="exists", ylab="Loops\n")

# It's count data, so try Poisson
# maxexits=rep(df$num, times=df$bound)
# 
# cb_mod=glm(maxexits ~ 1, family=Gamma(link="identity"))
# lines(1:18, dgamma(1:18, coef(cb_mod)[1])*sum(maxexits), col=pal_col[1])


cb_mod=gnm(bound ~ instances(Mult(1, Exp(num)), 2)-1,
                data=df, verbose=TRUE, trace=TRUE,
                start=c(ex_1, -1.2, ex_2, -0.1))
summary(cb_mod)

pred=predict(cb_mod)
lines(df$num, pred, col=pal_col[2])

exp_coef=as.numeric(coef(cb_mod))

lines(df$num, exp_coef[1]*exp(exp_coef[2]*df$num), col=pal_col[1])
lines(df$num, exp_coef[3]*exp(exp_coef[4]*df$num), col=pal_col[3])

return(cb_mod)
}


ex=read.csv(paste0(ESEUR_dir, "sourcecode/pani-exits.csv.xz"), as.is=TRUE)
ex=subset(ex, num > 0)

ex$allbound=ex$bound+ex$nonbound

cbench=subset(ex, project == "cBench")
CU=subset(ex, project == "coreutils")

# library(fitdistrplus)
#
# Cullen and Frey suggests Gamma or Negative binomial
# But both are convex and poor fits.
# maxexits=rep(cbench$num, times=cbench$bound)
# descdist(maxexits, boot=100)
# descdist(maxexits, boot=100, discrete=TRUE)
# 
# gam=fitdist(maxexits, distr="gamma", start=list(shape=1.0, rate=2), method="mle")
# dgam=dgamma(1:30, shape=gam$estimate[1], rate=gam$estimate[2])
# plot(1:30, dgam, log="y")
# 
# t=fitdist(maxexits, distr="nbinom", start=list(size=500.0, prob=0.2), method="mle")
# tnb=dnbinom(1:30, size=t$estimate[1], prob=t$estimate[2])
# plot(1:30, tnb, log="y")


cb_mod=fit_exits(cbench, 4000, 90)
CU_mod=fit_exits(CU, 1000, 9)


