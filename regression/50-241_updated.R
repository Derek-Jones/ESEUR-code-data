#
# 50-241_updated.R, 15 Jun 16
#
# Data from:
#
# Truth in advertising: Reporting performance of computer programs, algorithms and the impact of architecture and systems environment
# Scott Hazelhurst
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


bench=read.csv(paste0(ESEUR_dir, "regression/50-241_updated.csv.xz"), as.is=TRUE)

pal_col=rainbow(4)

plot(bench$L2, bench$T1, col=point_col,
	xlab="L2 cache size (MB)", ylab="Time (secs)\n")

inv_GHz=1/bench$GHz

L2_range=c(0, 0.5, 1:17)

# b_mod=glm(T1 ~ inv_GHz, data=bench)
# b_mod=glm(T1 ~ L2, data=bench) # The only significant variable

# b_mod=glm(T1 ~ L2+substr(gcc, 1, 1), data=bench)

b_mod=nls(T1 ~ c+a*exp(b*L2), data=bench,
		start=list(a=300, b=-0.1, c=60))

# b_mod=nls(T1 ~ c+a*L2^b, data=bench,
# 		start=list(a=300, b=-0.1, c=60))

pred=predict(b_mod, newdata=data.frame(L2=L2_range), type="response", se.fit=TRUE)
lines(L2_range, pred, col=pal_col[1])

# lines(pred$fit)
# lines(pred$fit+1.96*pred$se.fit)
# lines(pred$fit-1.96*pred$se.fit)

# Inverted the Michaelis-Menten equation
mm_mod=nls(T1 ~ (1+b*L2)/(a*L2), data=bench,
		start=list(b=3, a=0.004))

pred=predict(mm_mod, newdata=data.frame(L2=L2_range), type="response", se.fit=TRUE)

lines(L2_range, pred, col=pal_col[2])


# Inverted the Gompertz equation and made 'a' the nominator
gm_mod=nls(T1 ~ a/exp(b*exp(-c*L2)), data=bench,
		start=list(a=80, b=-1, c=0.1), trace=FALSE)

pred=predict(gm_mod, newdata=data.frame(L2=L2_range), type="response", se.fit=TRUE)

lines(L2_range, pred, col=pal_col[3])


# These start values don't work.  Eventually gave up and
# 'cheated' with SSweibull
# wb_mod=nls(T1 ~ a/(d-exp(-b*exp(c*L2))), data=bench,
# 		start=list(a=37, b=280, c=9, d=0.4), trace=TRUE)

Asym = 0.0125
Drop = 0.002
lrc = -1.0
pwr = 2.5
# 1/SSweibull does not have the desired effect, so have to invert
# the response.
getInitial(1/T1 ~ SSweibull(L2, Asym, Drop, lrc, pwr), data=bench)
wb_mod=nls(1/T1 ~ SSweibull(L2, Asym, Drop, lrc, pwr), data=bench)

pred=predict(wb_mod, newdata=data.frame(L2=L2_range), type="response", se.fit=TRUE)

lines(L2_range, 1/pred, col=pal_col[4])


legend(x="topright", legend=c("Exponential", "Michaelis-Menten", "Gompertz", "Weibull"), bty="n", fill=pal_col, cex=1.2)

