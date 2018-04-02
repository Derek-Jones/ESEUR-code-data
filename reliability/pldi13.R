#
# pldi13.R, 26 Mar 18
# Data from:
#
# Taming Compiler Fuzzers
# Yang Chen and Alex Groce and Xiaoli Fern and Chaoqiang Zhang and Weng-Keen Wong and Eric Eide and John Regehr
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


# The igraph package (which might be loaded when building the book)
# contains functions found in gnm.  The treemap package might also have
# been loaded, and its 'load' of igraph cannot be undone without first
# unloading treemap!
unloadNamespace("FrF2")
unloadNamespace("treemap")
unloadNamespace("igraph")
library("gnm")


plot_layout(2, 1)
pal_col=rainbow(3)


wrong=read.csv(paste0(ESEUR_dir, "reliability/wrong.csv.xz"), as.is=TRUE)

wrong_cnt=wrong[order(wrong$count, decreasing=TRUE), ]
wrong_cnt$ind=1:nrow(wrong_cnt)

plot(wrong_cnt$count, log="y", col=point_col,
	xlab="Fault id", ylab="Failing programs\n")

text(20, 300, "gcc", cex=1.4)

A1=1550
lrc1=-0.91
A2=45
lrc2=-0.17

# Fails to find a solution
# fail_mod=nls(count ~ SSbiexp(ind, A1, lrc1, A2, lrc2), data=wrong_cnt)

# fail_mod=nls(count ~ a*exp(-b*ind),
# 		start=list(a=1100, b=0.9), data=wrong_cnt[(1:9),])
# 
# fail_mod=nls(count ~ a*exp(-b*ind),
# 		start=list(a=1100, b=0.9), data=wrong_cnt[-(1:5),])
# 
# fail_mod=gnm(count ~ instances(Mult(1, Exp(ind)), 2),
# 		data=wrong_cnt,
# 		family=gaussian)

fail_mod=gnm(count ~ instances(Mult(1, Exp(ind)), 2)-1,
		data=wrong_cnt, verbose=FALSE,
		start=c(2000.0, -0.6, 30.0, -0.1),
		family=poisson(link="identity"))

# fail_mod=gnm(count ~ instances(Mult(1, Exp(ind)), 3)-1,
# 		data=wrong_cnt, verbose=FALSE,
# 		tolerance=1e-3,
# 		start=c(1500.0, -0.8, 15.0, -0.29, 2, -0.002),
# 		family=poisson(link="identity"))
#
# fail_mod=nls(count ~ a*exp(-b*ind)+c*exp(-d*ind),
# 		start=list(a=900, b=0.9, c=40, d=0.01), data=wrong_cnt[1:25,])

# fail_mod=nls(count ~ 1550*exp(-0.91*ind)+c*exp(-d*ind),
# 		start=list(c=35, d=0.04), data=wrong_cnt)

exp_coef=as.numeric(coef(fail_mod))

lines(exp_coef[1]*exp(exp_coef[2]*wrong_cnt$ind), col=pal_col[1])
lines(exp_coef[3]*exp(exp_coef[4]*wrong_cnt$ind), col=pal_col[3])

t=predict(fail_mod)
lines(t, col=pal_col[2])

# fail_mod=nls(log(count) ~ a*ind^b,
# 		start=list(a=log(1100), b=-0.9), data=wrong_cnt)


js1_6=read.csv(paste0(ESEUR_dir, "reliability/js1.6.csv.xz"), as.is=TRUE)

js1_6_cnt=js1_6[order(js1_6$count, decreasing=TRUE), ]
js1_6_cnt$ind=1:nrow(js1_6_cnt)

plot(js1_6_cnt$count, log="y", col=point_col,
	xlab="Fault id", ylab="Failing test programs\n")

text(15, 500, "SpiderMonkey", cex=1.4)

A1=1550
lrc1=0.91
A2=45
lrc2=0.17

# This one converges
# fail_mod=nls(count ~ SSbiexp(ind, A1, lrc1, A2, lrc2), data=js1_6_cnt)

# fail_mod=gnm(count ~ instances(Mult(1, Exp(ind)), 2),
# 		data=js1_6_cnt,
# 		family=gaussian)
fail_mod=gnm(count ~ instances(Mult(1, Exp(ind)), 2)-1,
		data=js1_6_cnt, verbose=FALSE,
		start=c(2000.0, -0.6, 30.0, -0.1),
		family=poisson(link="identity"))

# fail_mod=gnm(count ~ instances(Mult(1, Exp(ind)), 3)-1,
# 		data=js1_6_cnt, verbose=FALSE,
# 		start=c(2000.0, -0.6, 30.0, -0.1, 2, -0.0002),
# 		family=poisson(link="identity"))
#
# fail_mod=gnm(count ~ Exp(Mult(1, ind), inst=1)+Exp(Mult(1, ind), inst=2),
# 		data=js1_6_cnt,
# 		family=poisson)
# fail_mod=nls(count ~ a*exp(-b*ind),
# 		start=list(a=2300, b=0.6), data=js1_6_cnt[(1:11),])
# 
# fail_mod=nls(count ~ a*exp(-b*ind),
# 		start=list(a=30, b=0.2), data=js1_6_cnt[-(1:11),])
# 
# Various attempts to find other minima
# fail_mod=nls(count ~ 2500*exp(-0.75*ind)+c*exp(-d*ind),
# 		start=list(c=35, d=0.14), data=js1_6_cnt)
# fail_mod=nls(count ~ 2730*exp(-0.81*ind)+c*exp(-d*ind),
# 		start=list(c=35, d=0.14), data=js1_6_cnt)

exp_coef=as.numeric(coef(fail_mod))

lines(exp_coef[1]*exp(exp_coef[2]*wrong_cnt$ind), col=pal_col[1])
lines(exp_coef[3]*exp(exp_coef[4]*wrong_cnt$ind), col=pal_col[3])

t=predict(fail_mod)
lines(t, col=pal_col[2])


