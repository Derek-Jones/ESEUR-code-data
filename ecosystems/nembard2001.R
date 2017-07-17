#
# nembard2001.R,  4 Jul 17
# Data from:
# An Empirical Comparison of Forgetting Models
# David A. Nembhard and Napassavong Osothsilp
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)


exp_fit=function(df, days)
{
# Good luck getting a power law to fit over the cumulative production range
# pow_mod=nls(prod_time ~ a*production^b, data=df,
# 			start=list(a=0.17, b=-0.05))

if(nrow(df) < 5)
   return()
# print(nrow(df))

# An exponential model was investigated by Nembhard,
# and it is easily fitted for an example :-)
pow_mod=nls(prod_time ~ a*exp(b*production), data=df, trace=TRUE,
                        start=list(a=0.07, b=-0.001))
pred=predict(pow_mod)
lines(df$production, pred, col=pal_col[1])
# text(tail(df$production, 1), tail(pred, 1), days, pos=4)
}


nem=read.csv(paste0(ESEUR_dir, "ecosystems/nembard2001.csv.xz"), as.is=TRUE)
nem_breaks=read.csv(paste0(ESEUR_dir, "ecosystems/nembard-breaks.csv.xz"), as.is=TRUE)
prod_breaks=c(0, nem_breaks$production, max(nem$production))

plot(nem$production, nem$prod_time, col=pal_col[2],
	xlab="Units produced", ylab="Production time\n")

odd=seq(1, nrow(nem_breaks), by=2)
even=seq(2, nrow(nem_breaks), by=2)
text(nem_breaks$production[odd], 0.031, nem_breaks$days[odd])
text(nem_breaks$production[even], 0.034, nem_breaks$days[even])

dummy=sapply(1:(length(prod_breaks)-1), function(X) exp_fit(
		subset(nem, (production > prod_breaks[X]) &
				(production <= prod_breaks[X+1])),
		nem_breaks$days[X]))

# df=subset(df, production <= 569)
# pow_mod=nls(prod_time ~ a*production^b, data=df, trace=TRUE,
#                         start=list(a=0.19, b=-0.05))
# 
# pow_mod=nls(prod_time ~ a*exp(b*production), data=df, trace=TRUE,
#                         start=list(a=0.19, b=-0.005))


