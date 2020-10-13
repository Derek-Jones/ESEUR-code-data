#
# fault-profile-iwct17.R,  9 Sep 20
# Data from:
# A Model for t-way Fault Profile Evolution During Testing
# D. Richard Kuhn and Raghu N. Kacker and Yu Lei
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG testing_combinatorial fault_combinatorial

source("ESEUR_config.r")


pal_col=rainbow(10)

 
plot_fit=function(X)
{
points(ct$t, ct[, X], type="b", col=pal_col[X-1])

# This is not a good fit
# f_mod=nls(ct[, X] ~ c+a*(1-(1-b)^t), data=ct,
# 			start=list(a=100.0, b=0.5, c=40))
# pred=predict(f_mod)
# lines(ct$t, pred*100, col=pal_col[X-1])
# 
# print(summary(f_mod))
# 
# return(f_mod)
}

ct=read.csv(paste0(ESEUR_dir, "reliability/fault-profile-iwct17.csv.xz"), as.is=TRUE)

plot (0, type="n",
	yaxs="i",
	xlim=c(1, 6), ylim=c(8, 100),
	xlab="Factor combinations", ylab="Faults experienced (percentage)\n")

# dummy=sapply(2:11, function(X) lines(ct$t, ct[, X], type="b", col=pal_col[X-1]))
dummy=sapply(2:11, plot_fit)

legend(x="bottomright", legend=names(ct)[-1], bty="n", fill=pal_col, cex=1.2)

# The model proposed in the paper,
# which does not come close to fitting the data
# f_mod=nls(Firefox ~ 100*(1-r/2^(t-1))^k, data=ct, trace=TRUE,
# 			start=list(r=0.04, k=15))
# summary(f_mod)
# 
# plot(1:6, ct$Firefox, log="y")
# t=1:6
# 
# pl=function(r=0.05, k=40) lines(100*(1-r/2^(t-1))^k)
# 
# pl(0.04, 65)
# pl(0.04, 25)
# pl(0.04, 15)
# pl(0.02, 15)
# 
