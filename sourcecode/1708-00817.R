#
# 1708-00817.R, 27 Feb 20
# Data from:
# Revisiting Exception Handling Practices with Exception Flow Analysis
# Guilherme B. {de P\'{a}dua} and Weiyi Shang
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG try-blocks exceptions C# Java


source("ESEUR_config.r")


# The igraph package (which might be loaded when building the book)
# contains functions found in gnm.  The treemap package might also have
# been loaded, and its 'load' of igraph cannot be undone without first
# unloading treemap!
unloadNamespace("treemap")
unloadNamespace("igraph")
library("gnm")
library("plyr")


pal_col=rainbow(2)


ex=read.csv(paste0(ESEUR_dir, "sourcecode/1708-00817.csv.xz"), as.is=TRUE)

cs=subset(ex, Language == "C#")
java=subset(ex, Language == "Java")

java_cnt=count(java$PeId)
cs_cnt=count(cs$PeId)

plot(java_cnt, log="y", col=pal_col[1],
	xaxs="i",
	xlim=c(0, 40),
	xlab="Possible exceptions", ylab="Try blocks\n")
points(cs_cnt, col=pal_col[2])

legend(x="topright", legend=c("Java", "C#"), bty="n", fill=pal_col, cex=1.2)

# points(count(ex$Uncaught.PEID), col="red")

cs_mod=glm(log(freq) ~ x, data=cs_cnt)
# summary(cs_mod)

pred=predict(cs_mod)
lines(cs_cnt$x, exp(pred), col=pal_col[2])


acc_mod=gnm(freq ~ instances(Mult(1, Exp(x)), 2)-1,
                data=java_cnt, verbose=FALSE,
                start=c(9000.0, -0.5, 500, -0.1))

exp_coef=as.numeric(coef(acc_mod))

# lines(java_cnt$x, exp_coef[1]*exp(exp_coef[2]*java_cnt$x), col=pal_col[2])
# lines(java_cnt$x, exp_coef[3]*exp(exp_coef[4]*java_cnt$x), col=pal_col[3])
t=predict(acc_mod)
lines(java_cnt$x, t, col=pal_col[1])

# Power law fit is 'too curved'
# java_mod=glm(log(freq) ~ log(x), data=java_cnt)
# summary(java_mod)
# 
# pred=predict(java_mod)
# lines(java_cnt$x, exp(pred), col="red")


# library("pracma")
# 
# # A third exponential does not improve things
# me_mod=mexpfit(java_cnt$x, java_cnt$freq, p0=c(-0.9, -0.1, -0.01))
# print(me_mod)


