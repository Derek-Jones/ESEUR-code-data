#
# pani-depth.R, 13 Aug 18
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

depth=read.csv(paste0(ESEUR_dir, "sourcecode/pani-depth.csv.xz"), as.is=TRUE)

depth=subset(depth, num > 0)

cbench=subset(depth, project == "cBench")
CU=subset(depth, project == "coreutils")

# plot(cbench$num, cbench$bound, log="y", col=pal_col[1],
# 	xlim=c(0, 30),
# 	xlab="Max nesting", ylab="Loops")


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


cb_mod=fit_exits(cbench[1:30, ], 2500, -1.3, 220, -0.2)
CU_mod=fit_exits(CU[1:20, ],  700, -0.9, 10, -0.1)


