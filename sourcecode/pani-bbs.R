#
# pani-bbs.R.R, 13 Jan 19
# Data from:
# Loop Patterns in C Programs
# Thomas Pani
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG loop basic-block source-code_loop C_loop


source("ESEUR_config.r")


plot_layout(2, 1)
pal_col=rainbow(2)

bbs=read.csv(paste0(ESEUR_dir, "sourcecode/pani-bbs.csv.xz"), as.is=TRUE)

bbs=subset(bbs, (num > 0) & (bound > 0))

cbench=subset(bbs, project == "cBench")
CU=subset(bbs, project == "coreutils")

# plot(cbench$num, cbench$bound, log="y", col=pal_col[1],
# 	xlim=c(0, 80),
# 	xlab="Basic blocks", ylab="Loops")


fit_exits=function(df)
{
plot(df$num, df$bound, log="xy", col=pal_col[1],
        xlab="Basic blocks", ylab="Loops\n")

# It's count data, so try Poisson
# maxnest=rep(df$num, times=df$bound)
# 
# cb_mod=glm(maxnest ~ 1, family=poisson)
# lines(1:18, dpois(1:18, exp(coef(cb_mod)[1]))*sum(maxnest), col=pal_col[1])

cb_mod=glm(log(bound) ~ log(num), data=df)
# print(summary(cb_mod))

pred=predict(cb_mod)
lines(df$num, exp(pred), col=pal_col[2])

return(cb_mod)
}


cb_mod=fit_exits(cbench[2:50, ])
CU_mod=fit_exits(subset(CU, (num > 1) & (num < 20)))


