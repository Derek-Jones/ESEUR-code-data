#
# param-unused.R, 30 Jul 18
#
# Data from:
# The New {C Standard}: {An} Economic and Cultural Commentary
# Derek M. Jones
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# TAG C function parameter unused


source("ESEUR_config.r")


pal_col=rainbow(4)

# params,unused_param,num_funcs
num_unused=read.csv(paste0(ESEUR_dir, "sourcecode/param-unused.csv.xz"), as.is=TRUE)


max_y=max(num_unused$num_funcs)
plot(num_unused$num_funcs, type="b", log="y", col=pal_col[1],
	 ylim=c(1, max_y),
	 xlab="Parameters in definition/Unused parameters", ylab="Function definitions\n")

points(num_unused$unused_param, col=pal_col[2])

x=c(1:8)
# Derek's wet-finger fit
pred_unused=sapply(x, function(X) sum(num_unused$num_funcs[X:8]/(7*(X:8))))

lines(pred_unused, col=pal_col[3])

# A linear regression of the actual data
est_mod=glm(log(num_unused$unused_param) ~ x)

summary(est_mod)

pred=predict(est_mod)
lines(exp(pred), col=pal_col[4])

legend(x="bottomleft", legend=c("Functions", "Unused parameters", "Wet finger fit model", "Regression fit"), bty="n", fill=pal_col, cex=1.2)

