#
# pani-bbs.R.R, 13 Aug 18
# Data from:
# Loop Patterns in C Programs
# Thomas Pani
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG loop basic-block source C_loop


source("ESEUR_config.r")


library("gnm") 


plot_layout(2, 1)
pal_col=rainbow(3)

bbs=read.csv(paste0(ESEUR_dir, "sourcecode/pani-bbs.csv.xz"), as.is=TRUE)

bbs=subset(bbs, num > 0)

cbench=subset(bbs, project == "cBench")
CU=subset(bbs, project == "coreutils")

# plot(cbench$num, cbench$bound, log="y", col=pal_col[1],
# 	xlim=c(0, 80),
# 	xlab="Basic blocks", ylab="Loops")


fit_exits=function(df, ex_1, sl_1, ex_2, sl_2)
{
plot(df$num, df$bound, log="y", col=pal_col[2],
        xlab="Basic blocks", ylab="Loops\n")

# It's count data, so try Poisson
# maxnest=rep(df$num, times=df$bound)
# 
# cb_mod=glm(maxnest ~ 1, family=poisson)
# lines(1:18, dpois(1:18, exp(coef(cb_mod)[1]))*sum(maxnest), col=pal_col[1])


cb_mod=gnm(bound ~ instances(Mult(1, Exp(num)), 2)-1,
                data=df, verbose=TRUE, trace=TRUE,
                start=c(ex_1, sl_1, ex_2, sl_2))
summary(cb_mod)

pred=predict(cb_mod)
lines(df$num, pred, col=pal_col[2])

exp_coef=as.numeric(coef(cb_mod))

lines(df$num, exp_coef[1]*exp(exp_coef[2]*df$num), col=pal_col[1])
lines(df$num, exp_coef[3]*exp(exp_coef[4]*df$num), col=pal_col[3])

return(cb_mod)
}


cb_mod=fit_exits(cbench[2:50, ], 2500, -0.6, 120, -0.1)
CU_mod=fit_exits(CU[2:30, ],  700, -0.9, 10, -0.1)


