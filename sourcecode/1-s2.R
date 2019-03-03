#
# 1-s2.R, 14 Dec 18
# Data from:
# What to expect of predicates: An empirical analysis of predicates in real world programs
# Vinicius H.S. Durelli and Jeff Offutt and Nan Li and Marcio E. Delamaro and Jin Guo and Zengshu Shi and Xinge Ai
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG source_code conditions Java

source("ESEUR_config.r")


library("plyr")
library("reshape2")


p_conf=function(r, col_str)
{
# lines(1:4, 100*c(r$p2/r$p1, r$p3/r$p1, r$p4/r$p1, r$p5/r$p1))

t=rowSums(r[, 1:5])
lines(1:5, 100*c(r$p1/t, r$p2/t, r$p3/t, r$p4/t, r$p5/t), col=col_str)
}


s2=read.csv(paste0(ESEUR_dir, "sourcecode/1-s2.csv.xz"), as.is=TRUE)

pal_col=rainbow(nrow(s2))

plot(1, type="n", log="y",
	xaxs="i",
	xlim=c(1, 5), ylim=c(0.1, 90),
	xlab="Clauses", ylab="Conditions (percentage)\n")

dummy=sapply(1:nrow(s2), function(X) p_conf(s2[X, ], pal_col[X]))


ws2=melt(s2, measure.vars=paste0("p", 1:5))
ws2$pred=as.integer(mapvalues(ws2$variable, paste0("p", 1:5), 1:5))
ws2$avloc=log(ws2$SLOC)/log(ws2$Files)

# p_mod=glm(log(value+1e-5) ~ pred+pred:avloc+I((SLOC/Files)^2), data=ws2)
p_mod=glm(log(value+1e-5) ~ pred+pred:log(SLOC)+pred:log(Files)+I((SLOC/Files)^2), data=ws2)
summary(p_mod)

pred=predict(p_mod, newdata=data.frame(SLOC=1e5, Files=1e3, pred=1:5))

mean(s2$SLOC/sqrt(s2$Files))
# [1] 2625.939
max(s2$SLOC/sqrt(s2$Files))
# [1] 11710.65
min(s2$SLOC/sqrt(s2$Files))
# [1] 172.689

num_cond=function(sloc, nfiles, pred=1:5)
{
slen=sloc/sqrt(nfiles)
avlen=sloc/nfiles
return (3*slen^pred*exp(10-10*pred-1.8e-5*avlen^2))
}

plot(num_cond(1e5, 1e3), log="y",
	ylim=c(1e-8, 1e7))
lines(num_cond(2e5, 1e3))
lines(num_cond(4e5, 1e3))
lines(num_cond(5e5, 1e3))
lines(num_cond(7.5e5, 1e3))
lines(num_cond(1e6, 1e3))

