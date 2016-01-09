#
# 50-241_updated.R, 25 Feb 14
#
# Data from:
#
# Truth in advertising: Reporting performance of computer programs, algorithms and the impact of architecture and systems environment
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


bench=read.csv(paste0(ESEUR_dir, "regression/50-241_updated.csv.xz"), as.is=TRUE)

brew_col=rainbow(3)

plot(bench$L2, bench$T1, col=point_col)

inv_GHz=1/bench$GHz

L2_range=c(0, 0.5, 1:17)

b_mod=glm(T1 ~ inv_GHz, data=bench)
b_mod=glm(T1 ~ L2, data=bench) # The only significant variable

b_mod=glm(T1 ~ L2+substr(gcc, 1, 1), data=bench)

b_mod=nls(T1 ~ a*exp(b*L2), data=bench,
		start=list(a=300, b=-0.1))

b_mod=nls(T1 ~ a*L2^b, data=bench,
		start=list(a=300, b=-0.1))

pred=predict(b_mod, newdata=data.frame(inv_GHz=1/L2_range), type="response", se.fit=TRUE)
lines(L2_range, pred$fit, col="green")

pred=predict(b_mod, newdata=data.frame(L2=L2_range), type="response", se.fit=TRUE)

lines(L2_range, pred, col="blue")

# lines(pred$fit)
# lines(pred$fit+1.96*pred$se.fit)
# lines(pred$fit-1.96*pred$se.fit)

