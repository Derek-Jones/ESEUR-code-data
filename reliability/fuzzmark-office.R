#
# fuzzmark-office.R, 22 Feb 18
# Data from:
# Showing How Security Has (And Hasn't) Improved, After Ten Years Of Trying
# Dan Kaminsky and Michael Eddington and Adam Cecchetti
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("gnm")
library("plyr")


major_count=function(df)
{
W_df=subset(df, TargetName == "Word")

return(count(W_df$MajorHash))
}

pal_col=rainbow(5)

fuzz=read.csv(paste0(ESEUR_dir, "reliability/fuzzmark-office-pdf-11-Mar-2011.tsv.xz"), sep="\t", as.is=TRUE)

y2003=subset(fuzz, Year == 2003)
y2007=subset(fuzz, Year == 2007)
y2010=subset(fuzz, Year == 2010)


w03=major_count(y2003)
w07=major_count(y2007)
w10=major_count(y2010)

plot(sort(w03$freq, decreasing=TRUE), log="y", col=pal_col[1],
	xlim=c(1, 45),
	xlab="Crash fault", ylab="Occurrences\n")

points(sort(w07$freq, decreasing=TRUE), col=pal_col[2])
points(sort(w10$freq, decreasing=TRUE), col=pal_col[3])

legend(x="topright", legend=c("2003", "2007", "2010"), bty="n", fill=pal_col, cex=1.2)

w03=w03[order(w03$freq, decreasing=TRUE), ]
w03$duplicates=1:nrow(w03)

w03=w03[-1, ] # I can only get a fit by excluding the first count

w03_mod=gnm(freq ~ instances(Mult(1, Exp(duplicates)), 2)-1,
                data=w03, verbose=FALSE,
                start=c(9000.0, -1.0, 200.0, -0.04),
                family=poisson(link="identity"))
# summary(w03_mod)

exp_coef=as.numeric(coef(w03_mod))

lines(w03$duplicates, exp_coef[1]*exp(exp_coef[2]*w03$duplicates), col=pal_col[4])
lines(w03$duplicates, exp_coef[3]*exp(exp_coef[4]*w03$duplicates), col=pal_col[5])

# pred=predict(w03_mod)
# lines(w03$duplicates, pred, col=pal_col[2])

w07=w07[order(w07$freq, decreasing=TRUE), ]
w07$duplicates=1:nrow(w07)

w07=w07[-1, ] # I can only get a fit by excluding the first count

w07_mod=gnm(freq ~ instances(Mult(1, Exp(duplicates)), 2)-1,
                data=w07, verbose=FALSE, trace=FALSE,
                start=c(15000.0, -0.8, 100.0, -0.02),
                family=poisson(link="identity"))
# summary(w07_mod)

exp_coef=as.numeric(coef(w07_mod))

lines(w07$duplicates, exp_coef[1]*exp(exp_coef[2]*w07$duplicates), col=pal_col[4])
lines(w07$duplicates, exp_coef[3]*exp(exp_coef[4]*w07$duplicates), col=pal_col[5])

# pred=predict(w07_mod)
# lines(w07$duplicates, pred, col=pal_col[2])


w10=w10[order(w10$freq, decreasing=TRUE), ]
w10$duplicates=1:nrow(w10)

w10=w10[-1, ] # I can only get a fit by excluding the first count

w10_mod=gnm(freq ~ instances(Mult(1, Exp(duplicates)), 2)-1,
                data=w10, verbose=FALSE, trace=FALSE,
                start=c(12000.0, -0.8, 100.0, -0.02),
                family=poisson(link="identity"))
# summary(w10_mod)

exp_coef=as.numeric(coef(w10_mod))

lines(w10$duplicates, exp_coef[1]*exp(exp_coef[2]*w10$duplicates), col=pal_col[4])
lines(w10$duplicates, exp_coef[3]*exp(exp_coef[4]*w10$duplicates), col=pal_col[5])

# pred=predict(w10_mod)
# lines(w10$duplicates, pred, col=pal_col[2])


